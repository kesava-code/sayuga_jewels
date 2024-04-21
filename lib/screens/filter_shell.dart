import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/Widgets/action_bar_widget.dart';
import 'package:sayuga_jewels/Widgets/back_button.dart';
import 'package:sayuga_jewels/Widgets/filter_desktop.dart';
import 'package:sayuga_jewels/Widgets/filter_mobile.dart';
import 'package:sayuga_jewels/Widgets/flexible_space_widget.dart';
import 'package:sayuga_jewels/constants/enum.dart';
import 'package:sayuga_jewels/logic/cubit/filters_cubit.dart';
import 'package:sayuga_jewels/utils/screen_type.dart';

class FilterShell extends StatefulWidget {
  const FilterShell({super.key, required this.child});
  final StatefulNavigationShell child;
  static FormFactor formFactor = FormFactor();

  @override
  State<FilterShell> createState() => _FilterShellState();
}

class _FilterShellState extends State<FilterShell> {
  @override
  Widget build(BuildContext context) {
    ScreenType screenType = FilterShell.formFactor.getFormFactor(context);
    if (screenType == ScreenType.desktop) {
      double height = MediaQuery.of(context).size.height;
      return Scaffold(
        appBar: AppBar(
          leading: const MyBackButton(),
          actions: const [
            Expanded(
              child: ActionBarWidget(
                isHome: false,
                index: 0,
              ),
            )
          ],
          flexibleSpace: const FlexibleSpaceWidget(),
        ),
        body: SizedBox(
          height: height,
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              flex: 3,
              child: Container(
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                          end: BorderSide(
                              color: Theme.of(context).colorScheme.outline))),
                  constraints: const BoxConstraints.expand(),
                  child: const FilterDesktop()),
            ),
            Expanded(
              flex: 12,
              child: widget.child,
            )
          ]),
        ),
      );
    }
    Map<String, dynamic> queryParameters = Map.from(GoRouter.of(context)
        .routerDelegate
        .currentConfiguration
        .uri
        .queryParameters);

    return Scaffold(
      appBar: AppBar(
        leading: const MyBackButton(),
        actions: const [
          Expanded(
            child: ActionBarWidget(
              isHome: false,
              index: 0,
            ),
          )
        ],
        flexibleSpace: const FlexibleSpaceWidget(),
      ),
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            switch (value) {
              case 0:
                showModalBottomSheet(
                  showDragHandle: true,
                  context: context,
                  builder: (context) {
                    return Column(
                      children: SortingItems.values
                          .map((item) => ListTile(
                                title: Text(
                                  item.name,
                                  style: queryParameters["ordering"] ==
                                          item.value
                                      ? Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontWeight: FontWeight.bold)
                                      : Theme.of(context).textTheme.bodyMedium,
                                ),
                                onTap: () {
                                  if (queryParameters["ordering"] ==
                                      item.value) {
                                    context.pop();
                                    return;
                                  }
                                  context.pop();
                                  queryParameters["ordering"] = item.value;
                                  GoRouter.of(context).go(Uri(
                                          path: "/s",
                                          queryParameters: queryParameters)
                                      .toString());
                                },
                              ))
                          .toList(),
                    );
                  },
                );
                break;
              case 1:
                showModalBottomSheet(
                    constraints: const BoxConstraints.expand(),
                    isScrollControlled: true,
                    isDismissible: false,
                    enableDrag: false,
                    shape: const Border(),
                    context: context,
                    builder: (innerContext) {
                      return BlocProvider.value(
                        value: BlocProvider.of<FiltersCubit>(context),
                        child: const FilterMobile(),
                      );
                    });
                break;
              default:
                return;
            }
          },
          unselectedIconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).colorScheme.primary),
          selectedIconTheme: Theme.of(context)
              .iconTheme
              .copyWith(color: Theme.of(context).colorScheme.primary),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          useLegacyColorScheme: false,
          items: const [
            BottomNavigationBarItem(
                icon: DecoratedBox(
                  decoration:
                      BoxDecoration(border: Border(right: BorderSide())),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.sort_rounded),
                      Text("SORT"),
                    ],
                  ),
                ),
                label: ""),
            BottomNavigationBarItem(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [Icon(Icons.tune_rounded), Text("Filter")],
                ),
                label: ""),
          ]),
    );
  }
}
