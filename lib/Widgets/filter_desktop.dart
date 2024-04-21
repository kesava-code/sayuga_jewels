import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/logic/cubit/filters_cubit.dart';
import 'package:sayuga_jewels/logic/cubit/product_filter_details_cubit.dart';

class FilterDesktop extends StatefulWidget {
  const FilterDesktop({super.key});

  @override
  State<FilterDesktop> createState() => _FilterDesktopState();
}

class _FilterDesktopState extends State<FilterDesktop> {
  final TextEditingController _minPriceController = TextEditingController();

  final TextEditingController _maxPriceController = TextEditingController();

  @override
  void dispose() {
   
    _minPriceController.dispose();
    _maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductFilterDetailsCubit, ProductFilterDetailsState>(
      bloc: BlocProvider.of<ProductFilterDetailsCubit>(context),
      builder: (context, state) {
        if (state is ProductFilterDetailsLoaded) {
          return BlocBuilder<FiltersCubit, FiltersState>(
            bloc: BlocProvider.of<FiltersCubit>(context),
            builder: (context, filterState) {
              _minPriceController.text = filterState.minPrice ?? '';
              _maxPriceController.text = filterState.maxPrice ?? '';
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "FILTERS",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const Expanded(child: SizedBox()),
                            TextButton(
                                onPressed: () {
                                  GoRouter.of(context).go(
                                      "/s?ordering=${filterState.sort}&search=${filterState.search ?? ''}");
                                },
                                child: const Text(
                                  "CLEAR ALL",
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: Insets.medium,
                        ),
                        ExpansionTile(
                            shape: const Border(),
                            title: Text(
                              "GENDER",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    state.productFilterDetails.genders.length,
                                itemBuilder: (context, index) =>
                                    CheckboxListTile.adaptive(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        dense: true,
                                        tristate: false,
                                        title: Text(state.productFilterDetails
                                            .genders[index].name),
                                        value: filterState.genderIds.contains(
                                            state.productFilterDetails
                                                .genders[index].id),
                                        onChanged: (bool? value) {
                                          if (value!) {
                                            List<String> genderIds =
                                                filterState.genderIds;
                                            if (!genderIds.contains(state
                                                .productFilterDetails
                                                .genders[index]
                                                .id)) {
                                              genderIds.add(state
                                                  .productFilterDetails
                                                  .genders[index]
                                                  .id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          } else if (!value) {
                                            List<String> genderIds =
                                                filterState.genderIds;
                                            if (genderIds.contains(state
                                                .productFilterDetails
                                                .genders[index]
                                                .id)) {
                                              genderIds.remove(state
                                                  .productFilterDetails
                                                  .genders[index]
                                                  .id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          }
                                        }),
                              ),
                            ]),
                        const Divider(
                          thickness: 1,
                        ),
                        ExpansionTile(
                            shape: const Border(),
                            title: Text(
                              "CATEGORY",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: state
                                    .productFilterDetails.categories.length,
                                itemBuilder: (context, index) {
                                  bool isEnabled = filterState.categoryIds
                                      .contains(state.productFilterDetails
                                          .categories[index].id);
                                  return ExpansionTile(
                                    shape: const Border(),
                                    tilePadding: const EdgeInsets.all(0),
                                    childrenPadding:
                                        const EdgeInsets.only(left: Insets.medium),
                                    title: CheckboxListTile.adaptive(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        dense: true,
                                        tristate: false,
                                        title: Text(state.productFilterDetails
                                            .categories[index].name),
                                        value: isEnabled,
                                        onChanged: (bool? value) {
                                          if (value!) {
                                            List<String> categoryIds =
                                                filterState.categoryIds;
                                            if (!categoryIds.contains(state
                                                .productFilterDetails
                                                .categories[index]
                                                .id)) {
                                              categoryIds.add(state
                                                  .productFilterDetails
                                                  .categories[index]
                                                  .id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          } else if (!value) {
                                            List<String> categoryIds =
                                                filterState.categoryIds;
                                            if (categoryIds.contains(state
                                                .productFilterDetails
                                                .categories[index]
                                                .id)) {
                                              categoryIds.remove(state
                                                  .productFilterDetails
                                                  .categories[index]
                                                  .id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          }
                                        }),
                                    children: [
                                      ListView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: state
                                            .productFilterDetails
                                            .categories[index]
                                            .subCategories
                                            .length,
                                        itemBuilder: (context, subIndex) =>
                                            CheckboxListTile.adaptive(
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .leading,
                                                dense: true,
                                                tristate: false,
                                                title: Text(state
                                                    .productFilterDetails
                                                    .categories[index]
                                                    .subCategories[subIndex]
                                                    .name),
                                                value: filterState
                                                    .subCategoryIds
                                                    .contains(state
                                                        .productFilterDetails
                                                        .categories[index]
                                                        .subCategories[subIndex]
                                                        .id),
                                                onChanged: (bool? value) {
                                                  if (value!) {
                                                    List<String> ids =
                                                        filterState
                                                            .subCategoryIds;
                                                    if (!ids.contains(state
                                                        .productFilterDetails
                                                        .categories[index]
                                                        .subCategories[subIndex]
                                                        .id)) {
                                                      ids.add(state
                                                          .productFilterDetails
                                                          .categories[index]
                                                          .subCategories[
                                                              subIndex]
                                                          .id);
                                                    }
                                                    GoRouter.of(context).go(
                                                        "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${ids.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                                  } else if (!value) {
                                                    List<String> ids =
                                                        filterState
                                                            .subCategoryIds;
                                                    if (ids.contains(state
                                                        .productFilterDetails
                                                        .categories[index]
                                                        .subCategories[subIndex]
                                                        .id)) {
                                                      ids.remove(state
                                                          .productFilterDetails
                                                          .categories[index]
                                                          .subCategories[
                                                              subIndex]
                                                          .id);
                                                    }
                                                    GoRouter.of(context).go(
                                                        "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${ids.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                                  }
                                                }),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ]),
                        const Divider(
                          thickness: 1,
                        ),
                        ExpansionTile(
                          title: Text(
                            "PRICE",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          shape: const Border(),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Enter Price Range | ",
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                TextButton(
                                    onPressed: () {
                                      if ((filterState.maxPrice == null ||
                                              filterState.maxPrice == '') &&
                                          (filterState.minPrice == null ||
                                              filterState.minPrice == '')) {
                                        _minPriceController.text = '';
                                        _maxPriceController.text = '';
                                        return;
                                      }

                                      GoRouter.of(context).go(
                                          "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=&max_price=&search=${filterState.search ?? ''}");
                                    },
                                    child: Text(
                                      "Clear All",
                                      style: TextStyle(
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .labelMedium!
                                              .fontSize),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 40,
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      validator: (value) {
                                        // Optional validation function
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter minimum Price';
                                        }
                                        return null; // Return null for valid input
                                      },
                                      controller: _minPriceController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.all(Insets.small),
                                        isDense: true,
                                        border: OutlineInputBorder(),
                                        hintText: 'Min',
                                      ),
                                    ),
                                  ),
                                  const Text(' - '),
                                  Expanded(
                                    flex: 3,
                                    child: TextFormField(
                                      validator: (value) {
                                        // Optional validation function
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter maximum Price';
                                        }
                                        return null; // Return null for valid input
                                      },
                                      controller: _maxPriceController,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly
                                      ],
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.all(Insets.small),
                                        isDense: true,
                                        border: OutlineInputBorder(),
                                        hintText: 'Max',
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.all(Insets.xsmall),
                                        child: IconButton.filledTonal(
                                            visualDensity:
                                                VisualDensity.compact,
                                            onPressed: () {
                                              if (_maxPriceController.value.text != "" &&
                                                  _minPriceController
                                                          .value.text !=
                                                      "" &&
                                                  int.parse(_minPriceController
                                                          .value.text) <
                                                      int.parse(
                                                          _maxPriceController
                                                              .value.text)) {
                                                GoRouter.of(context).go(
                                                    "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${_minPriceController.value.text}&max_price=${_maxPriceController.value.text}&search=${filterState.search ?? ''}");
                                              }
                                            },
                                            icon: const Icon(Icons
                                                .arrow_forward_ios_rounded)),
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                        const Divider(
                          thickness: 1,
                        ),
                        ExpansionTile(
                            shape: const Border(),
                            title: Text(
                              "OCCASION",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    state.productFilterDetails.occasions.length,
                                itemBuilder: (context, index) =>
                                    CheckboxListTile.adaptive(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        dense: true,
                                        tristate: false,
                                        title: Text(state.productFilterDetails
                                            .occasions[index].name),
                                        value: filterState.ocassionIds.contains(
                                            state.productFilterDetails
                                                .occasions[index].id),
                                        onChanged: (bool? value) {
                                          if (value!) {
                                            List<String> occasionIds =
                                                filterState.ocassionIds;
                                            if (!occasionIds.contains(state
                                                .productFilterDetails
                                                .occasions[index]
                                                .id)) {
                                              occasionIds.add(state
                                                  .productFilterDetails
                                                  .occasions[index]
                                                  .id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${occasionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          } else if (!value) {
                                            List<String> occasionIds =
                                                filterState.ocassionIds;
                                            if (occasionIds.contains(state
                                                .productFilterDetails
                                                .occasions[index]
                                                .id)) {
                                              occasionIds.remove(state
                                                  .productFilterDetails
                                                  .occasions[index]
                                                  .id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${occasionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          }
                                        }),
                              ),
                            ]),
                        const Divider(
                          thickness: 1,
                        ),
                        ExpansionTile(
                            shape: const Border(),
                            title: Text(
                              "MATERIAL",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    state.productFilterDetails.materials.length,
                                itemBuilder: (context, index) =>
                                    CheckboxListTile.adaptive(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        dense: true,
                                        tristate: false,
                                        title: Text(state.productFilterDetails
                                            .materials[index].name),
                                        value: filterState.materialIds.contains(
                                            state.productFilterDetails
                                                .materials[index].id),
                                        onChanged: (bool? value) {
                                          if (value!) {
                                            List<String> ids =
                                                filterState.materialIds;
                                            if (!ids.contains(state
                                                .productFilterDetails
                                                .materials[index]
                                                .id)) {
                                              ids.add(state.productFilterDetails
                                                  .materials[index].id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${ids.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          } else if (!value) {
                                            List<String> ids =
                                                filterState.materialIds;
                                            if (ids.contains(state
                                                .productFilterDetails
                                                .materials[index]
                                                .id)) {
                                              ids.remove(state
                                                  .productFilterDetails
                                                  .materials[index]
                                                  .id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${ids.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          }
                                        }),
                              ),
                            ]),
                        const Divider(
                          thickness: 1,
                        ),
                        ExpansionTile(
                            shape: const Border(),
                            title: Text(
                              "STONE",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    state.productFilterDetails.stones.length,
                                itemBuilder: (context, index) =>
                                    CheckboxListTile.adaptive(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        dense: true,
                                        tristate: false,
                                        title: Text(state.productFilterDetails
                                            .stones[index].name),
                                        value: filterState.stoneIds.contains(
                                            state.productFilterDetails
                                                .stones[index].id),
                                        onChanged: (bool? value) {
                                          if (value!) {
                                            List<String> ids =
                                                filterState.stoneIds;
                                            if (!ids.contains(state
                                                .productFilterDetails
                                                .stones[index]
                                                .id)) {
                                              ids.add(state.productFilterDetails
                                                  .stones[index].id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${ids.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          } else if (!value) {
                                            List<String> ids =
                                                filterState.stoneIds;
                                            if (ids.contains(state
                                                .productFilterDetails
                                                .stones[index]
                                                .id)) {
                                              ids.remove(state
                                                  .productFilterDetails
                                                  .stones[index]
                                                  .id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${ids.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          }
                                        }),
                              ),
                            ]),
                        const Divider(
                          thickness: 1,
                        ),
                        ExpansionTile(
                            shape: const Border(),
                            title: Text(
                              "COLOR",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    state.productFilterDetails.colors.length,
                                itemBuilder: (context, index) =>
                                    CheckboxListTile.adaptive(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        dense: true,
                                        tristate: false,
                                        title: Text(state.productFilterDetails
                                            .colors[index].name),
                                        value: filterState.primaryColorIds
                                            .contains(state.productFilterDetails
                                                .colors[index].id),
                                        onChanged: (bool? value) {
                                          if (value!) {
                                            List<String> ids =
                                                filterState.primaryColorIds;
                                            if (!ids.contains(state
                                                .productFilterDetails
                                                .colors[index]
                                                .id)) {
                                              ids.add(state.productFilterDetails
                                                  .colors[index].id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${ids.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          } else if (!value) {
                                            List<String> ids =
                                                filterState.primaryColorIds;
                                            if (ids.contains(state
                                                .productFilterDetails
                                                .colors[index]
                                                .id)) {
                                              ids.remove(state
                                                  .productFilterDetails
                                                  .colors[index]
                                                  .id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${ids.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          }
                                        }),
                              ),
                            ]),
                        const Divider(
                          thickness: 1,
                        ),
                        ExpansionTile(
                            shape: const Border(),
                            title: Text(
                              "ACCENT COLOR",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            children: [
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount:
                                    state.productFilterDetails.colors.length,
                                itemBuilder: (context, index) =>
                                    CheckboxListTile.adaptive(
                                        controlAffinity:
                                            ListTileControlAffinity.leading,
                                        dense: true,
                                        tristate: false,
                                        title: Text(state.productFilterDetails
                                            .colors[index].name),
                                        value: filterState.secondaryColorIds
                                            .contains(state.productFilterDetails
                                                .colors[index].id),
                                        onChanged: (bool? value) {
                                          if (value!) {
                                            List<String> ids =
                                                filterState.secondaryColorIds;
                                            if (!ids.contains(state
                                                .productFilterDetails
                                                .colors[index]
                                                .id)) {
                                              ids.add(state.productFilterDetails
                                                  .colors[index].id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${ids.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          } else if (!value) {
                                            List<String> ids =
                                                filterState.secondaryColorIds;
                                            if (ids.contains(state
                                                .productFilterDetails
                                                .colors[index]
                                                .id)) {
                                              ids.remove(state
                                                  .productFilterDetails
                                                  .colors[index]
                                                  .id);
                                            }
                                            GoRouter.of(context).go(
                                                "/s?ordering=${filterState.sort}&gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${ids.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}");
                                          }
                                        }),
                              ),
                            ]),
                      ]),
                ),
              );
            },
          );
        }
        if (state is ProductFilterDetailsInitial) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return const Center(
          child: Text("error!"),
        );
      },
    );
  }
}
