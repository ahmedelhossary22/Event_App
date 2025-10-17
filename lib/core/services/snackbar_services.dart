import 'package:bot_toast/bot_toast.dart';
import 'package:event_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

abstract class SnackBarServices {
  static void showSuccessMessage(String message) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 3),
      dismissDirections: const [DismissDirection.endToStart],
      toastBuilder: (void Function() cancelFunc) {
        return _buildToast(
          message: message,
          backgroundColor: Colors.green.shade100,
          textColor: Colors.green.shade900,
          iconPath: Assets.icons.successIcn.path,
        );
      },
    );
  }

  static void showErrorMessage(String message) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 3),
      dismissDirections: const [DismissDirection.endToStart],
      toastBuilder: (void Function() cancelFunc) {
        return _buildToast(
          message: message,
          backgroundColor: Colors.red.shade100,
          textColor: Colors.red.shade900,
          iconPath:
              Assets.icons.errorIcn.path, // 🔸 Replace with your error icon
        );
      },
    );
  }

  static void showWarningMessage(String message) {
    BotToast.showCustomNotification(
      duration: const Duration(seconds: 3),
      dismissDirections: const [DismissDirection.endToStart],
      toastBuilder: (void Function() cancelFunc) {
        return _buildToast(
          message: message,
          backgroundColor: Colors.orange.shade100,
          textColor: Colors.orange.shade900,
          iconPath:
              Assets.icons.warningIcn.path, // 🔸 Replace with your warning icon
        );
      },
    );
  }

  static Widget _buildToast({
    required String message,
    required Color backgroundColor,
    required Color textColor,
    required String iconPath,
  }) {
    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 14.0),
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: textColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
