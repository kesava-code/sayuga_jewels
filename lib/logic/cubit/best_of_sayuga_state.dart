part of 'best_of_sayuga_cubit.dart';

enum BestOfSayugaStatus { initial, success, failure }

final class BestOfSayugaState extends Equatable {
  const BestOfSayugaState( 
      {this.status = BestOfSayugaStatus.initial,
      this.jewelryList = const <Jewelry>[],
      });
  final BestOfSayugaStatus status;
  final List<Jewelry> jewelryList;

  BestOfSayugaState copyWith(
      {BestOfSayugaStatus? status,
      List<Jewelry>? jewelryList,
     }) {
    return BestOfSayugaState(
     
        status: status ?? this.status,
        jewelryList: jewelryList ?? this.jewelryList,
       );
  }

  @override
  List<Object> get props =>
      [status, jewelryList];
}
