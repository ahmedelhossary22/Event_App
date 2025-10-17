import 'package:event_app/core/theme/color_pallate.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? buttonText;
  final Color? bacgroundColor;
  final Color? textColor;
  final Widget? child;

  const CustomButtonWidget({
    super.key,
    required this.onPressed,
    this.buttonText,
    this.bacgroundColor,
    this.textColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: bacgroundColor ?? ColorPallate.primaryColor,
        padding: EdgeInsets.symmetric(vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: BorderSide(color: ColorPallate.primaryColor),
        ),
      ),
      child:
          child ??
          Text(
            buttonText ?? '',
            style: theme.textTheme.titleLarge?.copyWith(color: Colors.white),
          ),
    );
  }
}
