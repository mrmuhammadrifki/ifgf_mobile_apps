import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Navigation {
  static final GlobalKey<NavigatorState> baseNavigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext get context =>
      router.routerDelegate.navigatorKey.currentContext!;

  static GoRouterDelegate get routerDelegate => router.routerDelegate;

  static GoRouteInformationParser get routeInformationParser =>
      router.routeInformationParser;

  static final List<RouteBase> _routes = [
    // GoRoute(
    //   path: RoutePath.login,
    //   pageBuilder: (context, GoRouterState state) {
    //     return _getPage(child: LoginScreen(), state: state);
    //   },
    // ),
  ];

  static Page _getPage({required Widget child, required GoRouterState state}) {
    return MaterialPage(key: state.pageKey, child: child);
  }

  static GoRouter router = GoRouter(
    navigatorKey: baseNavigatorKey,
    // initialLocation:
    //     AuthUtils.isAlreadySignIn() ? RoutePath.home : RoutePath.login,
    routes: _routes,
  );
}
