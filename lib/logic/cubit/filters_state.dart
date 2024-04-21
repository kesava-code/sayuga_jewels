part of 'filters_cubit.dart';

final class FiltersState {
  final List<String> primaryColorIds;
  final List<String> secondaryColorIds;
  final List<String> stoneIds;
  final List<String> materialIds;
  final List<String> ocassionIds;
  final List<String> categoryIds;
  final List<String> subCategoryIds;
  final List<String> genderIds;
  final String? maxPrice;
  final String? minPrice;
  final String? search;
  final String sort;
  const FiltersState( 
      {this.sort = "-id",
        this.secondaryColorIds = const [],
      this.search,
      this.stoneIds = const [],
      this.materialIds = const [],
      this.ocassionIds = const [],
      this.categoryIds = const [],
      this.subCategoryIds = const [],
      this.genderIds = const [],
      this.maxPrice,
      this.minPrice,
      this.primaryColorIds = const []});

  FiltersState copyWith(
      {List<String>? primaryColorIds,
      List<String>? secondaryColorIds,
      List<String>? stoneIds,
      List<String>? materialIds,
      List<String>? ocassionIds,
      List<String>? categoryIds,
      List<String>? subCategoryIds,
      List<String>? genderIds,
      String? search,
      String? sort,
      String? maxPrice,
      String? minPrice}) {
    return FiltersState(
        search: search ?? this.search,
        categoryIds: categoryIds ?? this.categoryIds,
        primaryColorIds: primaryColorIds ?? this.primaryColorIds,
        secondaryColorIds: secondaryColorIds ?? this.secondaryColorIds,
        stoneIds: stoneIds ?? this.stoneIds,
        materialIds: materialIds ?? this.materialIds,
        ocassionIds: ocassionIds ?? this.ocassionIds,
        subCategoryIds: subCategoryIds ?? this.subCategoryIds,
        genderIds: genderIds ?? this.genderIds,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        sort: sort ?? this.sort,
        
        );
  }

  @override
  String toString() {
    return 'FiltersState(primaryColorIds: $primaryColorIds, search: $search, secondaryColorIds: $secondaryColorIds, stoneIds: $stoneIds, materialIds: $materialIds, ocassionIds: $ocassionIds, categoryIds: $categoryIds, subCategoryIds: $subCategoryIds, genderIds: $genderIds, maxPrice: $maxPrice, minPrice: $minPrice)';
  }
}
