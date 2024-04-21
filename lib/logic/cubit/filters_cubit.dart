import 'package:bloc/bloc.dart';

part 'filters_state.dart';

class FiltersCubit extends Cubit<FiltersState> {
  FiltersCubit() : super(const FiltersState());
  void updateFilters(
      {List<String>? primaryColorIds,
      String? search,
      String? sort,
      List<String>? secondaryColorIds,
      List<String>? stoneIds,
      List<String>? materialIds,
      List<String>? ocassionIds,
      List<String>? categoryIds,
      List<String>? subCategoryIds,
      List<String>? genderIds,
      String? maxPrice,
      String? minPrice}) {
    emit(FiltersState(
        sort: sort ?? "-id",
        search: search,
        primaryColorIds: primaryColorIds ?? [],
        secondaryColorIds: secondaryColorIds ?? [],
        stoneIds: stoneIds ?? [],
        materialIds: materialIds ?? [],
        ocassionIds: ocassionIds ?? [],
        categoryIds: categoryIds ?? [],
        subCategoryIds: subCategoryIds ?? [],
        genderIds: genderIds ?? [],
        maxPrice: maxPrice,
        minPrice: minPrice));
  }

  void updatePrice(String? minPrice, String? maxPrice) {
    if (minPrice != null ) {
      minPrice = minPrice.trim();
    }
    if (maxPrice != null) {
      maxPrice = maxPrice.trim();
    }
    emit(state.copyWith(minPrice: minPrice, maxPrice: maxPrice));
  }

  void updateGender(String id, bool value) {
    List<String> ids = state.genderIds;
    if (value) {
      if (!ids.contains(id)) {
        ids.add(id);
        emit(state.copyWith(genderIds: ids));
      }
    } else {
      if (ids.contains(id)) {
        ids.remove(id);
        emit(state.copyWith(genderIds: ids));
      }
    }
  }

  void updateSubCategory(String id, bool value) {
    List<String> ids = state.subCategoryIds;
    if (value) {
      if (!ids.contains(id)) {
        ids.add(id);
        emit(state.copyWith(subCategoryIds: ids));
      }
    } else {
      if (ids.contains(id)) {
        ids.remove(id);
        emit(state.copyWith(subCategoryIds: ids));
      }
    }
  }

  void updateCategory(String id, bool value) {
    List<String> ids = state.categoryIds;
    if (value) {
      if (!ids.contains(id)) {
        ids.add(id);
        emit(state.copyWith(categoryIds: ids));
      }
    } else {
      if (ids.contains(id)) {
        ids.remove(id);
        emit(state.copyWith(categoryIds: ids));
      }
    }
  }

  void updatePrimaryColor(String id, bool value) {
    List<String> ids = state.primaryColorIds;
    if (value) {
      if (!ids.contains(id)) {
        ids.add(id);
        emit(state.copyWith(primaryColorIds: ids));
      }
    } else {
      if (ids.contains(id)) {
        ids.remove(id);
        emit(state.copyWith(primaryColorIds: ids));
      }
    }
  }

  void updateSecondaryColor(String id, bool value) {
    List<String> ids = state.secondaryColorIds;
    if (value) {
      if (!ids.contains(id)) {
        ids.add(id);
        emit(state.copyWith(secondaryColorIds: ids));
      }
    } else {
      if (ids.contains(id)) {
        ids.remove(id);
        emit(state.copyWith(secondaryColorIds: ids));
      }
    }
  }

  void updateStone(String id, bool value) {
    List<String> ids = state.stoneIds;
    if (value) {
      if (!ids.contains(id)) {
        ids.add(id);
        emit(state.copyWith(stoneIds: ids));
      }
    } else {
      if (ids.contains(id)) {
        ids.remove(id);
        emit(state.copyWith(stoneIds: ids));
      }
    }
  }

  void updateMaterial(String id, bool value) {
    List<String> ids = state.materialIds;
    if (value) {
      if (!ids.contains(id)) {
        ids.add(id);
        emit(state.copyWith(materialIds: ids));
      }
    } else {
      if (ids.contains(id)) {
        ids.remove(id);
        emit(state.copyWith(materialIds: ids));
      }
    }
  }

  void updateOcassion(String id, bool value) {
    List<String> ids = state.ocassionIds;
    if (value) {
      if (!ids.contains(id)) {
        ids.add(id);
        emit(state.copyWith(ocassionIds: ids));
      }
    } else {
      if (ids.contains(id)) {
        ids.remove(id);
        emit(state.copyWith(ocassionIds: ids));
      }
    }
  }
}
