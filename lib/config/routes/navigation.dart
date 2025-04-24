import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/bottom_navigation_page.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/presentation/pages/acara/acara_screen.dart';
import 'package:ifgf_apps/presentation/pages/create_acara/acara_provider/create_acara_provider.dart';
import 'package:ifgf_apps/presentation/pages/create_acara/create_acara.dart';
import 'package:ifgf_apps/presentation/pages/create_discipleship_journey/create_discipleship_journey.dart';
import 'package:ifgf_apps/presentation/pages/create_discipleship_journey/create_discipleship_journey_provider/create_discipleship_journey_provider.dart';
import 'package:ifgf_apps/presentation/pages/create_icare/create_icare.dart';
import 'package:ifgf_apps/presentation/pages/create_icare/create_icare_provider/create_icare_provider.dart';
import 'package:ifgf_apps/presentation/pages/create_super_sunday/create_super_sunday.dart';
import 'package:ifgf_apps/presentation/pages/create_super_sunday/create_super_sunday_provider/create_super_sunday_provider.dart';
import 'package:ifgf_apps/presentation/pages/create_trx/create_trx_screen.dart';
import 'package:ifgf_apps/presentation/pages/detail_jadwal/detail_jadwal.dart';
import 'package:ifgf_apps/presentation/pages/home/home_screen.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/jadwal_screen.dart';
import 'package:ifgf_apps/presentation/pages/keuangan/keuangan_page.dart';
import 'package:ifgf_apps/presentation/pages/login/login_screen.dart';
import 'package:ifgf_apps/presentation/pages/profile/profile_screen.dart';
import 'package:ifgf_apps/presentation/pages/register/register_screen.dart';
import 'package:provider/provider.dart';

class Navigation {
  static final GlobalKey<NavigatorState> baseNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> userHomeNavigatorKey =
      GlobalKey<NavigatorState>();

  static final GlobalKey<NavigatorState> userProfileNavigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  static GoRouterDelegate get routerDelegate => router.routerDelegate;

  static GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static final branches = <StatefulShellBranch>[
    StatefulShellBranch(
      navigatorKey: userHomeNavigatorKey,
      routes: [
        GoRoute(
          path: RoutePath.home,
          pageBuilder: (context, GoRouterState state) {
            return _getPage(child: HomeScreen(), state: state);
          },
        ),
      ],
    ),
    StatefulShellBranch(
      navigatorKey: userProfileNavigatorKey,
      routes: [
        GoRoute(
          path: RoutePath.profile,
          pageBuilder: (context, GoRouterState state) {
            return _getPage(child: const ProfileScreen(), state: state);
          },
        ),
      ],
    ),
  ];

  static final List<RouteBase> _routes = [
    StatefulShellRoute.indexedStack(
      parentNavigatorKey: baseNavigatorKey,
      branches: branches,
      pageBuilder: (
        BuildContext context,
        GoRouterState state,
        StatefulNavigationShell navigationShell,
      ) {
        return _getPage(
          child: BottomNavigationPage(child: navigationShell),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.login,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(child: LoginScreen(), state: state);
      },
    ),
    GoRoute(
      path: RoutePath.register,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(child: RegisterScreen(), state: state);
      },
    ),
    GoRoute(
      path: RoutePath.acara,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(child: AcaraScreen(), state: state);
      },
    ),
    GoRoute(
      path: RoutePath.createAcara,
      pageBuilder: (context, GoRouterState state) {
        final isEdit = state.extra as bool? ?? false;
        return _getPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CreateAcaraProvider(),
              ),
            ],
            child: CreateAcara(isEdit: isEdit),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.jadwal,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(child: JadwalScreen(), state: state);
      },
    ),
    GoRoute(
      path: RoutePath.detailJadwal,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(child: DetailJadwal(), state: state);
      },
    ),
    GoRoute(
      path: RoutePath.createSuperSunday,
      pageBuilder: (context, GoRouterState state) {
        final isEdit = state.extra as bool? ?? false;
        return _getPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CreateSuperSundayProvider(),
              ),
            ],
            child: CreateSuperSunday(isEdit: isEdit),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.createIcare,
      pageBuilder: (context, GoRouterState state) {
        final isEdit = state.extra as bool? ?? false;
        return _getPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CreateIcareProvider(),
              ),
            ],
            child: CreateIcare(isEdit: isEdit),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.createDiscipleshipJourney,
      pageBuilder: (context, GoRouterState state) {
        final isEdit = state.extra as bool? ?? false;
        return _getPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CreateDiscipleshipJourneyProvider(),
              ),
            ],
            child: CreateDiscipleshipJourney(isEdit: isEdit),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.keuangan,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(child: KeuanganPage(), state: state);
      },
    ),
    GoRoute(
      path: RoutePath.createTrx,
      pageBuilder: (context, GoRouterState state) {
        final isEdit = state.extra as bool? ?? false;
        return _getPage(child: CreateTrxScreen(isEdit: isEdit), state: state);
      },
    ),
  ];

  static Page _getPage({required Widget child, required GoRouterState state}) {
    return MaterialPage(key: state.pageKey, child: child);
  }

  static GoRouter router = GoRouter(
    navigatorKey: baseNavigatorKey,
    initialLocation: RoutePath.login,
    routes: _routes,
  );
}
