import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sayuga_jewels/client/jewelry_client.dart' as client;
import 'package:sayuga_jewels/data/models/jewlery_list_model.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
part 'jewelry_event.dart';
part 'jewelry_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class JewelryBloc extends Bloc<JewelryEvent, JewelryState> {
  JewelryBloc(
      {client.JewelryClient? jewelryClient, required this.queryParameters})
      : jewelryClient = jewelryClient ?? client.JewelryClient(),
        super(const JewelryState()) {
    on<JewelryFetched>(
      _onJewelryFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }
  final client.JewelryClient jewelryClient;
  final Map<String, dynamic> queryParameters;

  Future<void> _onJewelryFetched(
      JewelryFetched event, Emitter<JewelryState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == JewelryStatus.initial) {
        final JewelryList jewelryList =
            await jewelryClient.getJewelry(queryParameters);
        return emit(state.copyWith(
            status: JewelryStatus.success,
            jewelryList: jewelryList.results,
            hasReachedMax: jewelryList.next == "",
            next: jewelryList.next,
            previous: jewelryList.previous,
            count: jewelryList.count));
      }
      final Uri uri = Uri.parse(state.next);
      final JewelryList jewelryList =
          await jewelryClient.getJewelry(uri.queryParameters);
      emit(state.copyWith(
          status: JewelryStatus.success,
          jewelryList: List.of(state.jewelryList)..addAll(jewelryList.results),
          hasReachedMax: jewelryList.next == "",
          next: jewelryList.next,
          count: jewelryList.count,
          previous: jewelryList.previous));
    } catch (_) {
      emit(state.copyWith(status: JewelryStatus.failure));
    }
  }
}
