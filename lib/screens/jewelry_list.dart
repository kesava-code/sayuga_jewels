import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/Widgets/bottom_loader.dart';
import 'package:sayuga_jewels/Widgets/jewelry_list_item.dart';
import 'package:sayuga_jewels/constants/enum.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/logic/bloc/jewelry_bloc.dart';

class JewelryList extends StatefulWidget {
  const JewelryList({super.key});
  @override
  State<JewelryList> createState() => _JewelryListState();
}

class _JewelryListState extends State<JewelryList> {
  late final ScrollController _controller = ScrollController();
  String? search;
  @override
  void initState() {
    _controller.addListener(_onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _controller
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> queryParameters = Map.from(GoRouter.of(context)
        .routerDelegate
        .currentConfiguration
        .uri
        .queryParameters);

    search =
        queryParameters['search'] != null && queryParameters['search'] != ''
            ? queryParameters['search'].toString().toUpperCase()
            : '';

    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<JewelryBloc, JewelryState>(
      builder: (context, state) {
        switch (state.status) {
          case JewelryStatus.failure:
            return Center(
                child: Text(
              'failed to fetch Jewelry',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ));
          case JewelryStatus.success:
            if (state.jewelryList.isEmpty) {
              return const Center(
                  child: Text('No Results found for your search.'));
            }
            return SingleChildScrollView(
              controller: _controller,
              child: Padding(
                padding: const EdgeInsets.all(Insets.medium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          search ?? '',
                          style: Theme.of(context).textTheme.titleLarge,
                          softWrap: true,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          " - ${state.count.toString()} found.",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )
                      ],
                    ),
                    width > 900
                        ? SizedBox(
                            height: 60,
                            child: Row(
                              children: [
                                const Expanded(child: SizedBox()),
                                DropdownMenu(
                                  initialSelection: queryParameters['ordering'],
                                  onSelected: (value) {
                                    queryParameters["ordering"] = value;

                                    GoRouter.of(context).go(Uri(
                                            path: "/s",
                                            queryParameters: queryParameters)
                                        .toString());
                                  },
                                  inputDecorationTheme:
                                      const InputDecorationTheme(isDense: true),
                                  label: const Text(
                                    "Sort By",
                                  ),
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                  enabled: true,
                                  dropdownMenuEntries: SortingItems.values
                                      .map((SortingItems item) {
                                    return DropdownMenuEntry(
                                        style: MenuItemButton.styleFrom(
                                            padding: const EdgeInsets.all(0)),
                                        value: item.value,
                                        label: item.name,
                                        enabled: queryParameters['ordering']
                                                .toString() !=
                                            item.value);
                                  }).toList(),
                                ),
                                const SizedBox(
                                  width: 10,
                                )
                              ],
                            ))
                        : const SizedBox(),
                    const SizedBox(height: Insets.small),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: width > 900
                            ? Insets.extraLarge
                            : width > 600
                                ? Insets.large
                                : Insets.medium,
                        mainAxisSpacing: width > 900
                            ? Insets.medium
                            : width > 600
                                ? Insets.small
                                : Insets.xsmall,
                        crossAxisCount: width > 900
                            ? 4
                            : width > 600
                                ? 3
                                : 2,
                        childAspectRatio: 2 / 3,
                      ),
                      itemCount: state.hasReachedMax
                          ? state.jewelryList.length
                          : state.jewelryList.length + 1,
                      itemBuilder: (context, index) {
                        return index >= state.jewelryList.length
                            ? const BottomLoader()
                            : JewelryListItem(
                                jewelry: state.jewelryList[index]);
                      },
                    )
                  ],
                ),
              ),
            );
          case JewelryStatus.initial:
            return const Center(
              child: CupertinoActivityIndicator(),
            );
        }
      },
    );
  }

  void _onScroll() {
    if (_isBottom) context.read<JewelryBloc>().add(JewelryFetched());
  }

  bool get _isBottom {
    if (!_controller.hasClients) return false;
    final maxScroll = _controller.position.maxScrollExtent;
    final currentScroll = _controller.offset;
    return currentScroll >= (maxScroll * 0.8);
  }
}
