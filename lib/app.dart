import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ifgf_apps/config/environment/env.dart';
import 'package:ifgf_apps/config/routes/navigation.dart';
import 'package:ifgf_apps/config/themes/light_theme.dart';
import 'package:ifgf_apps/core/utils/enum.dart';
import 'package:ifgf_apps/data/data_sources/local/shared_pref.dart';
import 'package:ifgf_apps/data/data_sources/remote/acara_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/firebase_auth_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/firebase_storage_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/jadwal_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/keuangan_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/nats_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/profile_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/register_firestore_service.dart';
import 'package:ifgf_apps/presentation/pages/profile/provider/profile_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<Widget> initilizeApp(EnvType envType) async {
  Environment.type = envType;

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await SharedPref().init();
  log('SharedPref initialized');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  Intl.defaultLocale = 'id';
  await initializeDateFormatting('id_ID', null);

  FlutterNativeSplash.remove();

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
    final firebaseAuth = FirebaseAuth.instance;
    final firebaseFirestore = FirebaseFirestore.instance;
    final firebaseStorage = FirebaseStorage.instance;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProfileProvider(),
        ),
        Provider(
          create: (context) => FirebaseAuthService(
            auth: firebaseAuth,
          ),
        ),
        Provider(
          create: (context) => ProfileFirestoreService(
            firebaseFirestore,
          ),
        ),
        Provider(
          create: (context) => FirebaseStorageService(
            firebaseStorage,
          ),
        ),
        Provider(
          create: (context) => AcaraFirestoreService(
            firebaseFirestore,
          ),
        ),
        Provider(
          create: (context) => JadwalFirestoreService(
            firebaseFirestore,
          ),
        ),
        Provider(
          create: (context) => KeuanganFirestoreService(
            firebaseFirestore,
          ),
        ),
        Provider(
          create: (context) => RegisterFirestoreService(
            firebaseFirestore,
          ),
        ),
        Provider(
          create: (context) => NatsFirestoreService(
            firebaseFirestore,
          ),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        routerConfig: Navigation.router,
      ),
    );
  }
}
