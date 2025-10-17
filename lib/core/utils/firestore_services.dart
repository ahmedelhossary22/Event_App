import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/models/event_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  static CollectionReference<EventData> getCollectionRef() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception('No user logged in');
    }

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('events')
        .withConverter<EventData>(
          fromFirestore: (snapshot, _) =>
              EventData.fromFirestore(snapshot.data()!),
          toFirestore: (eventData, _) => eventData.toFireStore(),
        );
  }

  static Future<void> addNewEvent(EventData eventData) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc();
    eventData.eventID = docRef.id;
    await docRef.set(eventData);
  }

  static Future<List<EventData>> getAllEvents() async {
    var collectionRef = getCollectionRef();
    var data = await collectionRef.get();
    return data.docs.map((doc) => doc.data()).toList();
  }

  static Stream<QuerySnapshot<EventData>> getStreamOfEvents(String categoryID) {
    return getCollectionRef()
        .where("categoryID", isEqualTo: categoryID)
        .snapshots();
  }

  static Stream<QuerySnapshot<EventData>> getStreamOfFavEvents() {
    return getCollectionRef().where("isFavourite", isEqualTo: true).snapshots();
  }

  static Future<void> updateEvent(EventData eventData) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(eventData.eventID);
    await docRef.update(eventData.toFireStore());
  }

  static Future<void> deleteEvent(EventData eventData) async {
    var collectionRef = getCollectionRef();
    var docRef = collectionRef.doc(eventData.eventID);
    await docRef.delete();
  }
}
