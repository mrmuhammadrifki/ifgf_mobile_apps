import 'package:flutter/material.dart';
import 'package:ifgf_apps/app.dart';
import 'package:ifgf_apps/core/utils/enum.dart';


void main() async {
  Widget app = await initilizeApp(EnvType.dev);

  runApp(app);
}
