import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/navigation.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/core/utils/modal.dart';

class AuthUtils {
  // static bool isAlreadySignIn() => SharedPref.loginResponse != null;

  static void signOut({required void Function() onSuccess}) async {
    final keyLoader = GlobalKey<State>();
    final context = Navigation.context;

    Modal.showLoadingDialog(context, keyLoader);
    await Future.delayed(const Duration(milliseconds: 550));
    Navigator.of(keyLoader.currentContext!, rootNavigator: true).pop();

    if (!context.mounted) return;

    Future.delayed(const Duration(milliseconds: 550), () {
      // SharedPref().clear();
      context.go(RoutePath.login);
      onSuccess();
    });
  }
}
