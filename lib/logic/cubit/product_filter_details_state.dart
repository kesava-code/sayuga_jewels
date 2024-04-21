part of 'product_filter_details_cubit.dart';

sealed class ProductFilterDetailsState extends Equatable {
  const ProductFilterDetailsState();

  @override
  List<Object> get props => [];
}

final class ProductFilterDetailsInitial extends ProductFilterDetailsState {}

final class ProductFilterDetailsNotFound extends ProductFilterDetailsState {}

final class ProductFilterDetailsFailure extends ProductFilterDetailsState {}

final class ProductFilterDetailsLoaded extends ProductFilterDetailsState {
  final ProductFilterDetails productFilterDetails;
  const ProductFilterDetailsLoaded({required this.productFilterDetails});
 
}
