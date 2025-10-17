import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_app/core/routes/page_routes_name.dart';
import 'package:event_app/core/services/snackbar_services.dart';
import 'package:event_app/core/theme/color_pallate.dart';
import 'package:event_app/core/utils/firebase_auth_service.dart';
import 'package:event_app/core/widgets/custom_button_widget.dart';
import 'package:event_app/core/widgets/custom_text_form_field.dart';
import 'package:event_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.images.eventLogo.image(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.width * 0.25,
              ),
              SizedBox(height: 24),
              CustomTextFormField(
                controller: emailController,
                hintText: 'Email',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter an email';
                  }
                  final RegExp emailRegex = RegExp(
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                  );
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.emailIcn.image(width: 24),
                ),
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: passwordController,
                hintText: 'Password',
                isPassword: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.passwordIcn.image(width: 24),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(
                      context,
                    ).pushNamed(PageRoutesName.forgetPassword);
                  },
                  child: Text(
                    'Forget password',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorPallate.primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: ColorPallate.primaryColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              CustomButtonWidget(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    EasyLoading.show();
                    FirebaseAuthService.signIn(
                      emailController.text,
                      passwordController.text,
                    ).then((value) {
                      EasyLoading.dismiss();
                      if (value) {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          PageRoutesName.layout,
                          (route) => false,
                        );
                      }
                    });
                    SnackBarServices.showSuccessMessage('Login successfully');
                  }
                },
                buttonText: 'Login',
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Bounceable(
                    onTap: () {
                      Navigator.of(context).pushNamed(PageRoutesName.signUp);
                    },
                    child: Text(
                      'Create Account',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: ColorPallate.primaryColor,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorPallate.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      color: ColorPallate.primaryColor,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ),
                  Text(
                    'OR',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: ColorPallate.primaryColor,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: ColorPallate.primaryColor,
                      indent: 20,
                      endIndent: 20,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              CustomButtonWidget(
                onPressed: () async {
                  try {
                    final user = await FirebaseAuthService.loginWithGoogle();
                    if (user != null && mounted) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        PageRoutesName.layout,
                        (route) => false,
                      );
                    }
                  } on FirebaseException catch (e) {
                    SnackBarServices.showErrorMessage(
                      e.message ?? 'Google Sign-In failed',
                    );
                  }
                },
                buttonText: 'Login',
                bacgroundColor: Colors.transparent,
                textColor: ColorPallate.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Assets.icons.googleIcn.image(width: 24),

                    Text(
                      'Login with Google',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: ColorPallate.primaryColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
