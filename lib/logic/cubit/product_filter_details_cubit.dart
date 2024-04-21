import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sayuga_jewels/client/filter_details_client.dart' as client;
import 'package:sayuga_jewels/data/models/filter_details.dart';

part 'product_filter_details_state.dart';

class ProductFilterDetailsCubit extends Cubit<ProductFilterDetailsState> {
  ProductFilterDetailsCubit(
      {client.ProductFilterDetailsClient? productFilterDetailsClient})
      : productFilterDetailsClient =
            productFilterDetailsClient ?? client.ProductFilterDetailsClient(),
        super(ProductFilterDetailsInitial()) {
    getProductFilterDetails();
  }
  final client.ProductFilterDetailsClient productFilterDetailsClient;

  void getProductFilterDetails() async {
    try {
      ProductFilterDetails filterDetails =
          await productFilterDetailsClient.filterDetails();

      emit(ProductFilterDetailsLoaded(productFilterDetails: filterDetails));
    } catch (e) {
      if (e is client.ProductFilterDetailsNotFound) {
        emit(ProductFilterDetailsNotFound());
      }
      if (e is client.ProductFilterDetailsRequestFailure) {
        emit(ProductFilterDetailsFailure());
      }
    }
  }

  
}
