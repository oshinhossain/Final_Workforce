import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workforce/src/config/app_theme.dart';

enum Status {
  error,
  success,
}

class GetHelper {
  static void snackBar({required String text, required Status status}) {
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        status == Status.error ? 'Error' : 'Success',
        text,
        backgroundColor: AppTheme.primaryColor,
        colorText: AppTheme.textColor,
        icon: Icon(
          status == Status.error
              ? EvaIcons.alertCircleOutline
              : EvaIcons.doneAllOutline,
          color: AppTheme.textColor,
        ),
      );
    }
  }

  static void dialog({
    required String? text,
    required void Function()? onPressed,
  }) {
    if (!Get.isDialogOpen!) {
      Get.defaultDialog<void>(
        middleText: text!,
        title: '',
        backgroundColor: Colors.white,
        middleTextStyle: TextStyle(
          color: AppTheme.textColor,
          fontSize: 14,
        ),
        confirm: TextButton.icon(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              AppTheme.textColor,
            ),
          ),
          onPressed: onPressed,
          icon: Icon(Icons.info_outline),
          label: Text('OK'),
        ),
      );
    }
  }

  static void showDialog({
    required Widget? widget,
  }) {
    if (!Get.isDialogOpen!) {
      Get.defaultDialog<void>(
        content: widget,
        titlePadding: EdgeInsets.zero,
        backgroundColor: AppTheme.primaryColor,
      );
    }
  }

  static void deleteDialog({
    required String? text,
    required void Function()? onPressed,
  }) {
    if (!Get.isDialogOpen!) {
      Get.defaultDialog<void>(
        middleText: text!,
        title: '',
        backgroundColor: AppTheme.primaryColor,
        middleTextStyle: TextStyle(
          color: Colors.white54,
          fontSize: 14,
        ),
        confirm: TextButton.icon(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
              AppTheme.color3,
            ),
          ),
          onPressed: onPressed,
          icon: Icon(Icons.done),
          label: Text('Confrim'),
        ),
        cancel: TextButton.icon(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(AppTheme.color3),
          ),
          onPressed: () => Get.back<void>(),
          icon: Icon(Icons.close_outlined),
          label: Text('Cancel'),
        ),
      );
    }
  }
}
