import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sayuga_jewels/client/banner_client.dart' as client;
import 'package:sayuga_jewels/data/models/banner_data.dart';

part 'banner_state.dart';

class BannerCubit extends Cubit<BannerState> {
  BannerCubit({client.BannerClient? bannerClient})
      : bannerClient = bannerClient ?? client.BannerClient(),
        super(BannerState()) {
    getBannerData();
  }
  final client.BannerClient bannerClient;

  void getBannerData() async {
    try {
      BannerData bannerData = await bannerClient.getBanner();
      emit(BannerState(status: Status.success, bannerData: bannerData));
    } catch (e) {
      if (e is client.NotFound) {
        emit(BannerState(status: Status.failure));
      }
      if (e is client.RequestFailure) {
        emit(BannerState(status: Status.failure));
      }
      emit(BannerState(status: Status.failure));
    }
  }
}
