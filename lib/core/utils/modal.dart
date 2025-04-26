import 'package:flutter/material.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/core/utils/ext_text.dart';

base class Modal {
  static Future<bool?> showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Hapus',
    String cancelText = 'Batal',
  }) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(title).p20m().black2(),
          content: Text(message).p12r(),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              style: TextButton.styleFrom(
                foregroundColor: BaseColor.grey2,
              ),
              child: Text(cancelText),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: BaseColor.red,
                foregroundColor: BaseColor.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(confirmText),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showLoadingDialog(
    BuildContext context,
    GlobalKey key,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return PopScope(
          canPop: false,
          child: Center(
            key: key,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(BaseColor.white),
                  backgroundColor: BaseColor.softBlue,
                  strokeWidth: 3.0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context, {
    required String text,
    required SnackbarType snackbarType,
  }) {
    Color bgColor() {
      switch (snackbarType) {
        case SnackbarType.danger:
          return BaseColor.red.shade100;
        case SnackbarType.warning:
          return BaseColor.yellow.shade100;
        default:
          return BaseColor.green.shade100;
      }
    }

    Color borderColor() {
      switch (snackbarType) {
        case SnackbarType.danger:
          return BaseColor.red.shade300;
        case SnackbarType.warning:
          return BaseColor.yellow.shade300;
        default:
          return BaseColor.green.shade300;
      }
    }

    Color textColor() {
      switch (snackbarType) {
        case SnackbarType.danger:
          return BaseColor.red.shade800;
        case SnackbarType.warning:
          return BaseColor.yellow.shade800;
        default:
          return BaseColor.green.shade800;
      }
    }

    final snackBar = SnackBar(
      backgroundColor: bgColor(),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: borderColor()),
        borderRadius: BorderRadius.circular(6),
      ),
      content: Row(
        children: [
          Expanded(child: Text(text, style: TextStyle(color: textColor()))),
        ],
      ),
      closeIconColor: textColor(),
    );

    return ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static Future baseBottomSheet(
    BuildContext context, {
    required Widget child,
    bool useRootNavigator = true,
    bool showDragHandle = false,
  }) {
    return showModalBottomSheet(
      useRootNavigator: useRootNavigator,
      context: context,
      isScrollControlled: true,
      showDragHandle: showDragHandle,
      backgroundColor: BaseColor.white,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          decoration: const BoxDecoration(
            color: BaseColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: SafeArea(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height - 100,
              ),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
