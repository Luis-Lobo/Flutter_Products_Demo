import 'package:flutter/material.dart';
import 'package:flutter_products_demo/src/core/theme/application_colors.dart';
import 'package:flutter_products_demo/src/core/theme/application_styles_constants.dart';

class ProductSnackBar {

  static showAdditionSnackBar({
    required BuildContext context,
    required String message,
    double bottomMargin = 16,
    VoidCallback? onDismiss,
    Duration? duration,
    Widget? snackBarAction,
    bool? showCloseIcon,
  }) =>
      _showSnackBar(
        context: context,
        message: message,
        backgroundColor: ApplicationColors.green,
        textColor: ApplicationColors.white,
        onDismiss: onDismiss,
        duration: duration,
        snackBarAction: snackBarAction,
        showCloseIcon: showCloseIcon,
      );

  static showRemoveSnackBar({
    required BuildContext context,
    required String message,
    double bottomMargin = 16,
    VoidCallback? onDismiss,
    Duration? duration,
    Widget? snackBarAction,
    bool? showCloseIcon,
  }) =>
      _showSnackBar(
        context: context,
        message: message,
        backgroundColor: ApplicationColors.red,
        textColor: ApplicationColors.white,
        onDismiss: onDismiss,
        duration: duration,
        snackBarAction: snackBarAction,
        showCloseIcon: showCloseIcon,
      );

  static _showSnackBar({
    required BuildContext context,
    required String message,
    required Color backgroundColor,
    required Color textColor,
    double bottomMargin = 16,
    VoidCallback? onDismiss,
    Duration? duration,
    Widget? snackBarAction,
    bool? showCloseIcon = false,
  }) {
    final snackBar = SnackBar(
      key: const Key("SnackBarMessage"),
      content: Column(
        children: [
          Text(
            message,
         //   style: applicationTextTheme.bodyLarge?.copyWith(color: textColor),
          ),
          if (snackBarAction != null) ...[
            const SizedBox(height: ApplicationStylesConstants.spacing4Sp),
            snackBarAction,
          ]
        ],
      ),
      backgroundColor: backgroundColor,
      margin: EdgeInsets.fromLTRB(16, 0, 16, bottomMargin),
      padding: const EdgeInsets.all(16),
      duration: duration ?? const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: showCloseIcon,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then((value) {
      if (onDismiss != null) onDismiss();
    });
  }
}