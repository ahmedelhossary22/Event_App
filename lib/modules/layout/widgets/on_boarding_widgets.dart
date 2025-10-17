import 'package:event_app/core/theme/color_pallate.dart ';
import 'package:flutter/material.dart';

class OnBoardingWidgets extends StatelessWidget {
  final String imagePath;
  final String title;
  final String? description;

  const OnBoardingWidgets({
    super.key,
    required this.imagePath,
    required this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imagePath, height: 300, width: 300, fit: BoxFit.cover),
            const SizedBox(height: 20.0),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                color: ColorPallate.primaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            if (description != null && description!.isNotEmpty)
              Text(
                description!,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}
