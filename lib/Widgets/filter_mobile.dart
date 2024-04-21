import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sayuga_jewels/constants/insets.dart';
import 'package:sayuga_jewels/logic/cubit/filters_cubit.dart';
import 'package:sayuga_jewels/logic/cubit/product_filter_details_cubit.dart';

class FilterMobile extends StatefulWidget {
  const FilterMobile({super.key});

  @override
  State<FilterMobile> createState() => _FilterMobileState();
}

class _FilterMobileState extends State<FilterMobile> {
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
              return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Insets.medium),
                      child: Row(
                        children: [
                          Text(
                            "FILTERS",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const Expanded(child: SizedBox()),
                          TextButton(
                              onPressed: () {
                                BlocProvider.of<FiltersCubit>(context)
                                    .updateFilters(
                                        primaryColorIds: [],
                                        secondaryColorIds: [],
                                        stoneIds: [],
                                        materialIds: [],
                                        ocassionIds: [],
                                        categoryIds: [],
                                        subCategoryIds: [],
                                        genderIds: [],
                                        maxPrice: '',
                                        minPrice: '');
                              },
                              child: const Text(
                                "CLEAR ALL",
                              ))
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(Insets.medium),
                        children: [
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
                                            String id = state
                                                .productFilterDetails
                                                .genders[index]
                                                .id;
                                            BlocProvider.of<FiltersCubit>(
                                                    context)
                                                .updateGender(
                                                    id, value ?? false);
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
                                            String id = state
                                                .productFilterDetails
                                                .categories[index]
                                                .id;
                                            BlocProvider.of<FiltersCubit>(
                                                    context)
                                                .updateCategory(
                                                    id, value ?? false);
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
                                                          .subCategories[
                                                              subIndex]
                                                          .id),
                                                  onChanged: (bool? value) {
                                                    String id = state
                                                        .productFilterDetails
                                                        .categories[index]
                                                        .subCategories[subIndex]
                                                        .id;
                                                    BlocProvider.of<
                                                                FiltersCubit>(
                                                            context)
                                                        .updateSubCategory(
                                                            id, value ?? false);
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
                                        BlocProvider.of<FiltersCubit>(context)
                                            .updatePrice(
                                                _minPriceController.value.text,
                                                _maxPriceController.value.text);
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
                                          padding: const EdgeInsets.all(
                                              Insets.xsmall),
                                          child: IconButton.filledTonal(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              onPressed: () {
                                                if (_maxPriceController.value.text != "" &&
                                                    _minPriceController
                                                            .value.text !=
                                                        "" &&
                                                    int.parse(
                                                            _minPriceController
                                                                .value.text) <
                                                        int.parse(
                                                            _maxPriceController
                                                                .value.text)) {
                                                  BlocProvider.of<FiltersCubit>(
                                                          context)
                                                      .updatePrice(
                                                          _minPriceController
                                                              .value.text,
                                                          _maxPriceController
                                                              .value.text);
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
                                  itemCount: state
                                      .productFilterDetails.occasions.length,
                                  itemBuilder: (context, index) =>
                                      CheckboxListTile.adaptive(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          dense: true,
                                          tristate: false,
                                          title: Text(state.productFilterDetails
                                              .occasions[index].name),
                                          value: filterState.ocassionIds
                                              .contains(state
                                                  .productFilterDetails
                                                  .occasions[index]
                                                  .id),
                                          onChanged: (bool? value) {
                                            String id = state
                                                .productFilterDetails
                                                .occasions[index]
                                                .id;
                                            BlocProvider.of<FiltersCubit>(
                                                    context)
                                                .updateOcassion(
                                                    id, value ?? false);
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
                                  itemCount: state
                                      .productFilterDetails.materials.length,
                                  itemBuilder: (context, index) =>
                                      CheckboxListTile.adaptive(
                                          controlAffinity:
                                              ListTileControlAffinity.leading,
                                          dense: true,
                                          tristate: false,
                                          title: Text(state.productFilterDetails
                                              .materials[index].name),
                                          value: filterState.materialIds
                                              .contains(state
                                                  .productFilterDetails
                                                  .materials[index]
                                                  .id),
                                          onChanged: (bool? value) {
                                            String id = state
                                                .productFilterDetails
                                                .materials[index]
                                                .id;
                                            BlocProvider.of<FiltersCubit>(
                                                    context)
                                                .updateMaterial(
                                                    id, value ?? false);
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
                                            String id = state
                                                .productFilterDetails
                                                .stones[index]
                                                .id;
                                            BlocProvider.of<FiltersCubit>(
                                                    context)
                                                .updateStone(
                                                    id, value ?? false);
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
                                              .contains(state
                                                  .productFilterDetails
                                                  .colors[index]
                                                  .id),
                                          onChanged: (bool? value) {
                                            String id = state
                                                .productFilterDetails
                                                .colors[index]
                                                .id;
                                            BlocProvider.of<FiltersCubit>(
                                                    context)
                                                .updatePrimaryColor(
                                                    id, value ?? false);
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
                                              .contains(state
                                                  .productFilterDetails
                                                  .colors[index]
                                                  .id),
                                          onChanged: (bool? value) {
                                            String id = state
                                                .productFilterDetails
                                                .colors[index]
                                                .id;
                                            BlocProvider.of<FiltersCubit>(
                                                    context)
                                                .updateSecondaryColor(
                                                    id, value ?? false);
                                          }),
                                ),
                              ]),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: Insets.small, horizontal: Insets.large),
                        child: Row(children: [
                          Expanded(
                            child: ElevatedButton(
                                onPressed: () async {
                                  Map<String, dynamic> queryParameters =
                                      GoRouter.of(context)
                                          .routerDelegate
                                          .currentConfiguration
                                          .uri
                                          .queryParameters;
                                  BlocProvider.of<FiltersCubit>(context).updateFilters(
                                      primaryColorIds: queryParameters['primaryColor__id__in'] != ''
                                          ? queryParameters['primaryColor__id__in']
                                              ?.split(",")
                                          : [],
                                      search: queryParameters['search'],
                                      secondaryColorIds:
                                          queryParameters['secondaryColor__id__in'] != ''
                                              ? queryParameters['secondaryColor__id__in']
                                                  ?.split(",")
                                              : [],
                                      stoneIds: queryParameters['stone__id__in'] != ''
                                          ? queryParameters['stone__id__in']
                                              ?.split(",")
                                          : [],
                                      materialIds: queryParameters['material__id__in'] != ''
                                          ? queryParameters['material__id__in']
                                              ?.split(",")
                                          : [],
                                      ocassionIds: queryParameters['ocassion__id__in'] != ''
                                          ? queryParameters['ocassion__id__in']
                                              ?.split(",")
                                          : [],
                                      categoryIds: queryParameters['category__id__in'] != ''
                                          ? queryParameters['category__id__in']?.split(",")
                                          : [],
                                      subCategoryIds: queryParameters['subCategory__id__in'] != '' ? queryParameters['subCategory__id__in']?.split(",") : [],
                                      genderIds: queryParameters['gender__id__in'] != '' ? queryParameters['gender__id__in']?.split(",") : [],
                                      maxPrice: queryParameters['max_price'],
                                      minPrice: queryParameters['min_price'],
                                      sort: queryParameters['ordering']);
                                  context.pop();

                                  GoRouter.of(context).go(Uri(
                                          path: '/s',
                                          queryParameters: GoRouter.of(context)
                                              .routerDelegate
                                              .currentConfiguration
                                              .uri
                                              .queryParameters)
                                      .toString());
                                },
                                style: ElevatedButton.styleFrom(
                                    elevation: 2,
                                    shape: const RoundedRectangleBorder(),
                                    side: BorderSide(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .outline)),
                                child: const Text("Close")),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 2,
                                      shape: const RoundedRectangleBorder(),
                                      foregroundColor: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                      side: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .outline)),
                                  onPressed: () {
                                    context.pop();
                                    String filter =
                                        "/s?gender__id__in=${filterState.genderIds.join(',')}&primaryColor__id__in=${filterState.primaryColorIds.join(',')}&stone__id__in=${filterState.stoneIds.join(',')}&material__id__in=${filterState.materialIds.join(',')}&ocassion__id__in=${filterState.ocassionIds.join(',')}&category__id__in=${filterState.categoryIds.join(',')}&subCategory__id__in=${filterState.subCategoryIds.join(',')}&secondaryColor__id__in=${filterState.secondaryColorIds.join(',')}&min_price=${filterState.minPrice ?? ''}&max_price=${filterState.maxPrice ?? ''}&search=${filterState.search ?? ''}";

                                    GoRouter.of(context).go(filter);
                                  },
                                  child: const Text("Apply")))
                        ]),
                      ),
                    )
                  ]);
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
