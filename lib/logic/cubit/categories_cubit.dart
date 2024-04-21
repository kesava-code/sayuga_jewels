import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sayuga_jewels/client/category_client.dart' as client;
import 'package:sayuga_jewels/data/models/category_model.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({client.CategoryClient? categoryClient})
      : categoryClient = categoryClient ?? client.CategoryClient(),
        super(const CategoriesState()) {
    getCategoriesData();
  }
  final client.CategoryClient categoryClient;

  void getCategoriesData() async {
    try {
      List<JewelryCategory> data = await categoryClient.getCategories();
      emit(CategoriesState(status: CategoryStatus.success, categories: data));
    } catch (e) {
      if (e is client.NotFound) {
        emit(const CategoriesState(status: CategoryStatus.failure));
      }
      if (e is client.RequestFailure) {
        emit(const CategoriesState(status: CategoryStatus.failure));
      }
      emit(const CategoriesState(status: CategoryStatus.failure));
    }
  }
}
