import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sayuga_jewels/client/new_for_you_client.dart' as client;
import 'package:sayuga_jewels/data/models/best_of_sayuga_model.dart';

part 'new_for_you_state.dart';

class NewForYouCubit extends Cubit<NewForYouState> {
  NewForYouCubit({client.NewForYouClient? newForYouClient})
      : newForYouClient = newForYouClient ?? client.NewForYouClient(),
        super(const NewForYouState()) {
    getData();
  }
final client.NewForYouClient newForYouClient;

  void getData() async {
    try {
      JewelryList data = await newForYouClient.getNewForYou();
      if (data.results.length < 3) {
        emit(const NewForYouState(status: NewForYouStatus.failure));
        return;
      }
      emit(NewForYouState(
          status: NewForYouStatus.success, jewelryList: data.results));
    } catch (e) {
      if (e is client.NotFound) {
        emit(const NewForYouState(status: NewForYouStatus.failure));
      }
      if (e is client.RequestFailure) {
        emit(const NewForYouState(status: NewForYouStatus.failure));
      }
      emit(const NewForYouState(status: NewForYouStatus.failure));
    }
  }

}
