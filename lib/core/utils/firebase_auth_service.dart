import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/services/snackbar_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static Future<bool> createAccount(String email, String password) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(credential.user!.uid).set({
        'email': credential.user!.email,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await credential.user?.updateDisplayName(email.split('@')[0]);
      SnackBarServices.showSuccessMessage("Account created successfully");
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarServices.showErrorMessage('Password is too weak');
      } else if (e.code == 'email-already-in-use') {
        SnackBarServices.showErrorMessage('Account already exists');
      }
      return false;
    } catch (e) {
      SnackBarServices.showErrorMessage('Error creating account');
      return false;
    }
  }

  static Future<bool> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      SnackBarServices.showSuccessMessage('Login successful');
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        SnackBarServices.showErrorMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        SnackBarServices.showErrorMessage('Wrong password provided.');
      }
      return false;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<User?> loginWithGoogle() async {
    final googleAccount = await GoogleSignIn().signIn();
    final googleAuth = await googleAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final userCredential = await FirebaseAuth.instance.signInWithCredential(
      credential,
    );
    return userCredential.user;
  }

  static User? get currentUser => _auth.currentUser;
}
