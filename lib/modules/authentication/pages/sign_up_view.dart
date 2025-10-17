import 'package:event_app/core/theme/color_pallate.dart';
import 'package:event_app/core/utils/firebase_auth_service.dart';
import 'package:event_app/core/widgets/custom_button_widget.dart';
import 'package:event_app/core/widgets/custom_text_form_field.dart';
import 'package:event_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _formKey,
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
                controller: _nameController,
                hintText: 'Name',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.personIcn.image(width: 24),
                ),
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _emailController,
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
                controller: _passwordController,
                hintText: 'Password',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a password';
                  }
                  final RegExp passwordRegex = RegExp(
                    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                  );
                  if (!passwordRegex.hasMatch(value)) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                isPassword: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.passwordIcn.image(width: 24),
                ),
              ),
              SizedBox(height: 16),
              CustomTextFormField(
                controller: _confirmPasswordController,
                hintText: ' Re Password',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a password';
                  }
                  final RegExp passwordRegex = RegExp(
                    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                  );
                  if (!passwordRegex.hasMatch(value)) {
                    return 'Please enter a valid password';
                  }
                  return null;
                },
                isPassword: true,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Assets.icons.passwordIcn.image(width: 24),
                ),
              ),

              SizedBox(height: 24),
              CustomButtonWidget(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    FirebaseAuthService.createAccount(
                      _emailController.text,
                      _passwordController.text,
                    );
                  }
                },
                buttonText: 'Create Account',
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already Have  Account?',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Bounceable(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
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
            ],
          ),
        ),
      ),
    );
  }
}
