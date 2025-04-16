import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ifgf_apps/config/environment/env.dart';
import 'package:ifgf_apps/config/routes/navigation.dart';
import 'package:ifgf_apps/config/themes/base_color.dart';
import 'package:ifgf_apps/config/themes/light_theme.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Future<Widget> initilizeApp(EnvType envType) async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: BaseColor.black,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: BaseColor.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  Environment.type = envType;

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // await SharedPref().init();
  log('SharedPref initialized');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Intl.defaultLocale = 'id';
  await initializeDateFormatting('id_ID', null);

  // FlutterNativeSplash.remove();

  return const App();
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      routerConfig: Navigation.router,
    );
  }
}
