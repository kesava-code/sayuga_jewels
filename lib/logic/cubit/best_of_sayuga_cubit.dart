import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sayuga_jewels/client/best_of_sayuga_client.dart' as client;
import 'package:sayuga_jewels/data/models/best_of_sayuga_model.dart';

part 'best_of_sayuga_state.dart';

class BestOfSayugaCubit extends Cubit<BestOfSayugaState> {
  BestOfSayugaCubit({client.BestOfSayugaClient? bestOfSayugaClient})
      : bestOfSayugaClient = bestOfSayugaClient ?? client.BestOfSayugaClient(),
        super(const BestOfSayugaState()) {
    getData();
  }

  final client.BestOfSayugaClient bestOfSayugaClient;

  void getData() async {
    try {
      JewelryList data = await bestOfSayugaClient.getBestOfSayuga();
      if (data.results.length < 6) {
        emit(const BestOfSayugaState(status: BestOfSayugaStatus.failure));
        return;
      }
      emit(BestOfSayugaState(
          status: BestOfSayugaStatus.success, jewelryList: data.results));
    } catch (e) {
      if (e is client.NotFound) {
        emit(const BestOfSayugaState(status: BestOfSayugaStatus.failure));
      }
      if (e is client.RequestFailure) {
        emit(const BestOfSayugaState(status: BestOfSayugaStatus.failure));
      }
      emit(const BestOfSayugaState(status: BestOfSayugaStatus.failure));
    }
  }
}
