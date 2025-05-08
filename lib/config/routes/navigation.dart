import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ifgf_apps/config/routes/bottom_navigation_page.dart';
import 'package:ifgf_apps/config/routes/route_path.dart';
import 'package:ifgf_apps/core/utils/auth_utils.dart';
import 'package:ifgf_apps/data/data_sources/remote/acara_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/firebase_auth_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/firebase_storage_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/jadwal_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/keuangan_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/profile_firestore_service.dart';
import 'package:ifgf_apps/data/data_sources/remote/register_firestore_service.dart';
import 'package:ifgf_apps/data/models/create_acara_params.dart';
import 'package:ifgf_apps/data/provider/firebase_auth_provider.dart';
import 'package:ifgf_apps/presentation/pages/acara/acara_screen.dart';
import 'package:ifgf_apps/presentation/pages/acara/cubit/cubit/list_acara_cubit.dart';
import 'package:ifgf_apps/presentation/pages/acara/provider/acara_provider.dart';
import 'package:ifgf_apps/presentation/pages/create_acara/create_acara_provider/create_acara_provider.dart';
import 'package:ifgf_apps/presentation/pages/create_acara/create_acara.dart';
import 'package:ifgf_apps/presentation/pages/create_jadwal_discipleship_journey/create_jadwal_discipleship_journey.dart';
import 'package:ifgf_apps/presentation/pages/create_jadwal_discipleship_journey/create_jadwal_discipleship_journey_provider/create_jadwal_discipleship_journey_provider.dart';
import 'package:ifgf_apps/presentation/pages/create_jadwak_icare/create_jadwal_icare.dart';
import 'package:ifgf_apps/presentation/pages/create_jadwak_icare/create_jadwal_icare_provider/create_jadwal_icare_provider.dart';
import 'package:ifgf_apps/presentation/pages/create_jadwal_super_sunday/create_jadwal_super_sunday.dart';
import 'package:ifgf_apps/presentation/pages/create_jadwal_super_sunday/create_jadwal_super_sunday_provider/create_jadwal_super_sunday_provider.dart';
import 'package:ifgf_apps/presentation/pages/create_trx/create_trx_screen.dart';
import 'package:ifgf_apps/presentation/pages/create_trx/provider/create_trx_provider.dart';
import 'package:ifgf_apps/presentation/pages/detail_jadwal/cubit/detail_jadwal_cubit.dart';
import 'package:ifgf_apps/presentation/pages/detail_jadwal/detail_jadwal.dart';
import 'package:ifgf_apps/presentation/pages/detail_jadwal/provider/detail_jadwal_provider.dart';
import 'package:ifgf_apps/presentation/pages/edit_profile/edit_profile_screen.dart';
import 'package:ifgf_apps/presentation/pages/home/home_screen.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/cubit/list_discipleship_journey_cubit.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/cubit/list_icare_cubit.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/cubit/list_super_sunday_cubit.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/jadwal_screen.dart';
import 'package:ifgf_apps/presentation/pages/jadwal/provider/jadwal_provider.dart';
import 'package:ifgf_apps/presentation/pages/jemaat/cubit/list_jemaat_cubit.dart';
import 'package:ifgf_apps/presentation/pages/keuangan/cubit/list_trx_cubit.dart';
import 'package:ifgf_apps/presentation/pages/keuangan/keuangan_screen.dart';
import 'package:ifgf_apps/presentation/pages/jemaat/jemaat_screen.dart';
import 'package:ifgf_apps/presentation/pages/keuangan/provider/keuangan_provider.dart';
import 'package:ifgf_apps/presentation/pages/login/login_screen.dart';
import 'package:ifgf_apps/presentation/pages/member_discipleship_journey/cubit/list_member_discipleship_journey_cubit.dart';
import 'package:ifgf_apps/presentation/pages/member_discipleship_journey/member_discipleship_journey_screen.dart';
import 'package:ifgf_apps/presentation/pages/member_icare/member_icare_screen.dart';
import 'package:ifgf_apps/presentation/pages/profile/profile_screen.dart';
import 'package:ifgf_apps/presentation/pages/register/register_screen.dart';
import 'package:ifgf_apps/presentation/pages/register_auth/register_auth_screen.dart';
import 'package:ifgf_apps/presentation/pages/register_discipleship_journey/provider/register_discipleship_journey_provider.dart';
import 'package:ifgf_apps/presentation/pages/register_discipleship_journey/register_discipleship_journey_screen.dart';
import 'package:ifgf_apps/presentation/pages/register_icare/cubit/list_member_icare_cubit.dart';
import 'package:ifgf_apps/presentation/pages/register_icare/provider/register_icare_provider.dart';
import 'package:ifgf_apps/presentation/pages/register_icare/register_icare_screen.dart';
import 'package:ifgf_apps/presentation/pages/register_jemaat/provider/register_jemaat_provider.dart';
import 'package:ifgf_apps/presentation/pages/register_jemaat/register_jemaat_screen.dart';
import 'package:ifgf_apps/presentation/pages/tentang_kami/tentang_kami_screen.dart';
import 'package:ifgf_apps/presentation/widgets/photo_view.dart';
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
            return _getPage(
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (_) => FirebaseAuthProvider(
                        context.read<FirebaseAuthService>(),
                        context.read<ProfileFirestoreService>(),
                      ),
                    )
                  ],
                  child: ProfileScreen(),
                ),
                state: state);
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
        return _getPage(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => FirebaseAuthProvider(
                    context.read<FirebaseAuthService>(),
                    context.read<ProfileFirestoreService>(),
                  ),
                )
              ],
              child: LoginScreen(),
            ),
            state: state);
      },
    ),
    GoRoute(
      path: RoutePath.registerAuth,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => FirebaseAuthProvider(
                    context.read<FirebaseAuthService>(),
                    context.read<ProfileFirestoreService>(),
                  ),
                )
              ],
              child: RegisterAuthScreen(),
            ),
            state: state);
      },
    ),
    GoRoute(
      path: RoutePath.acara,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(
            child: MultiProvider(
              providers: [
                BlocProvider(
                  create: (context) => ListAcaraCubit(),
                ),
                ChangeNotifierProvider(
                  create: (context) => AcaraProvider(
                    context.read<FirebaseStorageService>(),
                    context.read<AcaraFirestoreService>(),
                  ),
                ),
              ],
              child: AcaraScreen(),
            ),
            state: state);
      },
    ),
    GoRoute(
      path: RoutePath.createAcara,
      pageBuilder: (context, GoRouterState state) {
        final params = state.extra as CreateAcaraParams;
        return _getPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CreateAcaraProvider(
                  context.read<FirebaseStorageService>(),
                  context.read<AcaraFirestoreService>(),
                ),
              ),
            ],
            child: CreateAcara(isEdit: params.isEdit, id: params.id),
          ),
          state: state,
        );
      },
    ),
     GoRoute(
      path: RoutePath.tentangKami,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(child: TentangKamiScreen(), state: state);
      },
    ),
     GoRoute(
      path: RoutePath.photoView,
      pageBuilder: (context, GoRouterState state) {
          final image = state.extra as String;
        return _getPage(child: PhotoViewPage(image: image), state: state);
      },
    ),
    GoRoute(
      path: RoutePath.jadwal,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(
          child: MultiProvider(
            providers: [
              BlocProvider(
                create: (context) => ListSuperSundayCubit(),
              ),
              BlocProvider(
                create: (context) => ListIcareCubit(),
              ),
              BlocProvider(
                create: (context) => ListDiscipleshipJourneyCubit(),
              ),
              ChangeNotifierProvider(
                create: (context) => JadwalProvider(
                  context.read<FirebaseStorageService>(),
                  context.read<JadwalFirestoreService>(),
                ),
              ),
            ],
            child: JadwalScreen(),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.detailJadwal,
      pageBuilder: (context, GoRouterState state) {
        final id = state.extra as String;
        return _getPage(
          child: MultiProvider(
            providers: [
              BlocProvider(
                create: (context) => DetailJadwalCubit(),
              ),
              ChangeNotifierProvider(
                create: (context) => DetailJadwalProvider(
                    context.read<JadwalFirestoreService>()),
              ),
            ],
            child: DetailJadwal(id: id),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.createJadwalSuperSunday,
      pageBuilder: (context, GoRouterState state) {
        final params = state.extra as CreateAcaraParams?;
        return _getPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CreateJadwalSuperSundayProvider(
                  context.read<FirebaseStorageService>(),
                  context.read<JadwalFirestoreService>(),
                ),
              ),
            ],
            child: CreateJadwalSuperSunday(
                isEdit: params?.isEdit ?? false, id: params?.id),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.createJadwalIcare,
      pageBuilder: (context, GoRouterState state) {
        final params = state.extra as CreateAcaraParams?;
        return _getPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CreateJadwalIcareProvider(
                  context.read<FirebaseStorageService>(),
                  context.read<JadwalFirestoreService>(),
                ),
              ),
            ],
            child: CreateJadwalIcare(
                isEdit: params?.isEdit ?? false, id: params?.id ?? ""),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.createJadwalDiscipleshipJourney,
      pageBuilder: (context, GoRouterState state) {
        final params = state.extra as CreateAcaraParams?;
        return _getPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CreateJadwalDiscipleshipJourneyProvider(
                  context.read<FirebaseStorageService>(),
                  context.read<JadwalFirestoreService>(),
                ),
              ),
            ],
            child: CreateJadwalDiscipleshipJourney(
                isEdit: params?.isEdit, id: params?.id),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.keuangan,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => KeuanganProvider(
                    context.read<KeuanganFirestoreService>(),
                  ),
                ),
                BlocProvider(
                  create: (context) => ListTrxCubit(),
                ),
              ],
              child: KeuanganScreen(),
            ),
            state: state);
      },
    ),
    GoRoute(
      path: RoutePath.createTrx,
      pageBuilder: (context, GoRouterState state) {
        final params = state.extra as CreateAcaraParams?;
        return _getPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => CreateTrxProvider(
                  context.read<KeuanganFirestoreService>(),
                ),
              ),
            ],
            child: CreateTrxScreen(isEdit: params?.isEdit, id: params?.id),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.register,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(child: RegisterScreen(), state: state);
      },
    ),
    GoRoute(
      path: RoutePath.jemaat,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(
          child: MultiProvider(
            providers: [
              BlocProvider(
                create: (context) => ListJemaatCubit(),
              )
            ],
            child: JemaatScreen(),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.memberIcare,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(
            child: MultiProvider(providers: [
              BlocProvider(
                create: (context) => ListMemberIcareCubit(),
              ),
              ChangeNotifierProvider(
                create: (context) => RegisterIcareProvider(
                  context.read<RegisterFirestoreService>(),
                ),
              ),
            ], child: MemberIcareScreen()),
            state: state);
      },
    ),
    GoRoute(
      path: RoutePath.memberDiscipleshipJourney,
      pageBuilder: (context, GoRouterState state) {
        return _getPage(
          child: MultiProvider(
            providers: [
              BlocProvider(
                create: (context) => ListMemberDiscipleshipJourneyCubit(),
              ),
              ChangeNotifierProvider(
                create: (context) => RegisterDiscipleshipJourneyProvider(
                  context.read<RegisterFirestoreService>(),
                ),
              ),
            ],
            child: MemberDiscipleshipJourneyScreen(),
          ),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.registerJemaat,
      pageBuilder: (context, GoRouterState state) {
        final params = state.extra as CreateAcaraParams?;
        return _getPage(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => FirebaseAuthProvider(
                    context.read<FirebaseAuthService>(),
                    context.read<ProfileFirestoreService>(),
                  ),
                ),
                ChangeNotifierProvider(
                  create: (context) => RegisterJemaatProvider(
                    context.read<FirebaseStorageService>(),
                    context.read<ProfileFirestoreService>(),
                  ),
                ),
              ],
              child:
                  RegisterJemaatScreen(isEdit: params?.isEdit, id: params?.id),
            ),
            state: state);
      },
    ),
    GoRoute(
      path: RoutePath.editProfile,
      pageBuilder: (context, GoRouterState state) {
        final id = state.extra as String?;
        return _getPage(
            child: MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (context) => RegisterJemaatProvider(
                    context.read<FirebaseStorageService>(),
                    context.read<ProfileFirestoreService>(),
                  ),
                ),
              ],
              child: EditProfileScreen(id: id),
            ),
            state: state);
      },
    ),
    GoRoute(
      path: RoutePath.registerIcare,
      pageBuilder: (context, GoRouterState state) {
        final params = state.extra as CreateAcaraParams;
        return _getPage(
          child: MultiProvider(providers: [
            ChangeNotifierProvider(
              create: (context) => RegisterIcareProvider(
                context.read<RegisterFirestoreService>(),
              ),
            ),
          ], child: RegisterIcareScreen(isEdit: params.isEdit, id: params.id)),
          state: state,
        );
      },
    ),
    GoRoute(
      path: RoutePath.registerDiscipleshipJourney,
      pageBuilder: (context, GoRouterState state) {
        final params = state.extra as CreateAcaraParams?;
        return _getPage(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => RegisterDiscipleshipJourneyProvider(
                  context.read<RegisterFirestoreService>(),
                ),
              )
            ],
            child: RegisterDiscipleshipJourneyScreen(
              isEdit: params?.isEdit,
              id: params?.id,
            ),
          ),
          state: state,
        );
      },
    ),
  ];

  static Page _getPage({required Widget child, required GoRouterState state}) {
    return MaterialPage(key: state.pageKey, child: child);
  }

  static GoRouter router = GoRouter(
    navigatorKey: baseNavigatorKey,
    initialLocation:
        AuthUtils.isAlreadySignIn() ? RoutePath.home : RoutePath.login,
    routes: _routes,
  );
}
