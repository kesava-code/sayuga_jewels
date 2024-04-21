import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:sayuga_jewels/Widgets/action_bar_widget.dart';
import 'package:sayuga_jewels/Widgets/back_button.dart';
import 'package:sayuga_jewels/Widgets/flexible_space_widget.dart';
import 'package:sayuga_jewels/logic/cubit/product_filter_details_cubit.dart';
import 'package:sayuga_jewels/routes/routes.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  final ProductFilterDetailsCubit productFilterDetailsCubit =
      ProductFilterDetailsCubit();
  //Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(
    productFilterDetailsCubit: productFilterDetailsCubit,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.productFilterDetailsCubit});
  final ProductFilterDetailsCubit productFilterDetailsCubit;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => productFilterDetailsCubit,
      lazy: false,
      child: MaterialApp.router(
        routerConfig: Routes.router,
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData(
          fontFamily: 'Gilda',
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff6750A4), brightness: Brightness.dark),
          useMaterial3: true,
        ),
        themeMode: ThemeMode.system,
        theme: ThemeData(
          fontFamily: 'Gilda',
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff6750A4), brightness: Brightness.light),
          useMaterial3: true,
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.child, required this.index});
  final Widget child;
  final int index;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // This widget is the home page of your application. It is stateful, meaning
  @override
  Widget build(BuildContext context) {
    ScreenType screenType = FormFactor().getFormFactor(context);

    return Scaffold(
      body: CustomScrollView(
        primary: true,
        slivers: [
          SliverAppBar(
              leading: kIsWeb ? const MyBackButton() : null,
              actions: [
                Expanded(
                  child: ActionBarWidget(
                    isHome: true,
                    index: widget.index,
                  ),
                )
              ],
              pinned: true,
              expandedHeight: 70,
              flexibleSpace: const FlexibleSpaceWidget()),
          SliverToBoxAdapter(child: widget.child)
        ],
      ),
      bottomNavigationBar: screenType == ScreenType.handset
          ? BottomNavigationBar(
              currentIndex: widget.index,
              onTap: (value) {
                if (value == widget.index) {
                  return;
                }
                switch (value) {
                  case 0:
                    context.go("/");
                  case 1:
                    context.go("/about-us");
                  case 2:
                    context.go("/custom-design");
                  default:
                    return;
                }
              },
              items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home_rounded), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.info_rounded), label: 'About Us'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.support_agent_rounded), label: 'Couture')
                ])
          : null,
    );
  }
}
