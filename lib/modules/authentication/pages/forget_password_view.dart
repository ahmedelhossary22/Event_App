import 'package:event_app/core/widgets/custom_button_widget.dart';
import 'package:event_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forget Password')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Assets.images.resetPasswordImage.image(),
            CustomButtonWidget(onPressed: () {}, buttonText: 'Reset Password'),
          ],
        ),
      ),
    );
  }
}
