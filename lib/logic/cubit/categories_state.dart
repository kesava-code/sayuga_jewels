part of 'categories_cubit.dart';

enum CategoryStatus { initial, success, failure }

final class CategoriesState extends Equatable {
  const CategoriesState(
      {this.status = CategoryStatus.initial,
      this.categories = const <JewelryCategory>[]});

  final CategoryStatus status;
  final List<JewelryCategory> categories;

  CategoriesState copyWith(
      {CategoryStatus? status, List<JewelryCategory>? categories}) {
    return (CategoriesState(
        status: status ?? this.status,
        categories: categories ?? this.categories));
  }

  @override
  List<Object> get props => [status, categories];
}
