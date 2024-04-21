import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/logic/bloc/jewelry_bloc.dart';
import 'package:sayuga_jewels/logic/cubit/filters_cubit.dart';
import 'package:sayuga_jewels/logic/cubit/jewelry_details_cubit.dart';
import 'package:sayuga_jewels/main.dart';
import 'package:sayuga_jewels/screens/about_us.dart';
import 'package:sayuga_jewels/screens/custom_design.dart';
import 'package:sayuga_jewels/screens/filter_shell.dart';
import 'package:sayuga_jewels/screens/home.dart';
import 'package:sayuga_jewels/screens/jewelry_details.dart';
import 'package:sayuga_jewels/screens/interactive_viewer.dart';
import 'package:sayuga_jewels/screens/jewelry_list.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class Routes {
  static final GoRouter router = GoRouter(
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      routes: <RouteBase>[
        GoRoute(
          path: "/",
          routes: [
            StatefulShellRoute.indexedStack(
                pageBuilder: (BuildContext context, GoRouterState state,
                    StatefulNavigationShell navigationShell) {
                  return CustomFadeTransition(
                    child: BlocProvider(
                      create: (context) => FiltersCubit(),
                      lazy: false,
                      child: FilterShell(child: navigationShell),
                    ),
                  );
                },
                branches: [
                  StatefulShellBranch(
                    navigatorKey: _shellNavigatorKey,
                    routes: [
                      GoRoute(
                        parentNavigatorKey: _shellNavigatorKey,
                        path: "s",
                        pageBuilder: (context, state) {
                          BlocProvider.of<FiltersCubit>(context).updateFilters(
                              primaryColorIds: state.uri.queryParameters['primaryColor__id__in'] != ''
                                  ? state.uri.queryParameters['primaryColor__id__in']
                                      ?.split(",")
                                  : [],
                              search: state.uri.queryParameters['search'],
                              secondaryColorIds:
                                  state.uri.queryParameters['secondaryColor__id__in'] != ''
                                      ? state.uri.queryParameters['secondaryColor__id__in']
                                          ?.split(",")
                                      : [],
                              stoneIds: state.uri.queryParameters['stone__id__in'] != ''
                                  ? state.uri.queryParameters['stone__id__in']
                                      ?.split(",")
                                  : [],
                              materialIds: state.uri.queryParameters['material__id__in'] != ''
                                  ? state.uri.queryParameters['material__id__in']
                                      ?.split(",")
                                  : [],
                              ocassionIds: state.uri.queryParameters['ocassion__id__in'] != ''
                                  ? state.uri.queryParameters['ocassion__id__in']?.split(",")
                                  : [],
                              categoryIds: state.uri.queryParameters['category__id__in'] != '' ? state.uri.queryParameters['category__id__in']?.split(",") : [],
                              subCategoryIds: state.uri.queryParameters['subCategory__id__in'] != '' ? state.uri.queryParameters['subCategory__id__in']?.split(",") : [],
                              genderIds: state.uri.queryParameters['gender__id__in'] != '' ? state.uri.queryParameters['gender__id__in']?.split(",") : [],
                              maxPrice: state.uri.queryParameters['max_price'],
                              minPrice: state.uri.queryParameters['min_price'],
                              sort: state.uri.queryParameters['ordering']);

                          return CustomFadeTransition(
                              key: ValueKey(state.uri),
                              child: BlocProvider(
                                create: (context) => JewelryBloc(
                                    queryParameters: state.uri.queryParameters)
                                  ..add(JewelryFetched()),
                                lazy: false,
                                child: const JewelryList(),
                              ));
                        },
                      ),
                    ],
                  )
                ]),
            GoRoute(
              path: "image-view",
              pageBuilder: (context, state) {
                return CustomFadeTransition(
                  child: BlocProvider.value(
                      value: state.extra as JewelryDetailsCubit,
                      child: ImageInteractiveViewer(
                        currentImage: int.parse(
                            state.uri.queryParameters['currentIndex']!),
                      )),
                );
              },
            ),
            GoRoute(
              path: "jewelry/:fid",
              pageBuilder: (context, state) {
                return CustomFadeTransition(
                    child: MyHomePage(
                        index: 0,
                        child:
                            JewelryDetails(id: state.pathParameters['fid']!)));
              },
            ),
            GoRoute(
              path: "about-us",
              pageBuilder: (context, state) {
                return CustomFadeTransition(
                    child: const MyHomePage(index: 1, child: AboutUs()));
              },
            ),
            GoRoute(
              path: "custom-design",
              pageBuilder: (context, state) {
                return CustomFadeTransition(
                    child: const MyHomePage(index: 2, child: CustomDesign()));
              },
            ),
          ],
          pageBuilder: (context, state) {
            return CustomFadeTransition(
                child: const MyHomePage(
              index: 0,
              child: HomePage(),
            ));
          },
        ),
      ]);

  /// Appl
}

class CustomFadeTransition extends CustomTransitionPage<void> {
  CustomFadeTransition({super.key, required super.child})
      : super(
          transitionDuration: const Duration(milliseconds: 0),
          transitionsBuilder: (_, animation, __, child) {
            return child;
          },
        );
}
