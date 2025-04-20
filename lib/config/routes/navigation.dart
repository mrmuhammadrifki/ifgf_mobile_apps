import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/bottom_navigation_page.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/presentation/pages/home/home_screen.dart';
import 'package:ifgf_apps/presentation/pages/login/login_screen.dart';
import 'package:ifgf_apps/presentation/pages/profile/profile_screen.dart';
import 'package:ifgf_apps/presentation/pages/register/register_screen.dart';

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
