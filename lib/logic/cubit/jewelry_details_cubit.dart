import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sayuga_jewels/client/jewelry_detail_client.dart' as client;
import 'package:sayuga_jewels/data/models/jewelry_details_model.dart';

part 'jewelry_details_state.dart';

class JewelryDetailsCubit extends Cubit<JewelryDetailsState> {
  JewelryDetailsCubit(
      {client.JewelryDetailsClient? jewelryDetailsClient, required this.id})
      : jewelryDetailsClient =
            jewelryDetailsClient ?? client.JewelryDetailsClient(),
        super(JewelryDetailsInitial()) {
    getJewelry(id);
  }

  final client.JewelryDetailsClient jewelryDetailsClient;
  final int id;

  void getJewelry(int id) async {
    try {
     
      JewelryDetailsModel jewelryDetails =
          await jewelryDetailsClient.getJewelryDetails(id);
      emit(JewelryDetailsLoaded(jewelry: jewelryDetails));
    } catch (e) {
      if (e is client.JewelryDetailsNotFound) {
        emit(JewelryDetailsNotFound());
      }
      if (e is client.JewelryRequestFailure) {
        emit(JewelryDetailsFailure());
      }
    }
  }

  
}
