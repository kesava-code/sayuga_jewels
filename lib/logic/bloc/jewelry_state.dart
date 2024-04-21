part of 'jewelry_bloc.dart';

enum JewelryStatus { initial, success, failure }

final class JewelryState extends Equatable {
  const JewelryState( 
      {this.status = JewelryStatus.initial,
      this.jewelryList = const <Jewelry>[],
      this.hasReachedMax = false,
      this.previous = "",
      this.next = "",
       this.count = 0,
      });
  final JewelryStatus status;
  final List<Jewelry> jewelryList;
  final bool hasReachedMax;
  final String previous;
  final String next;
  final int count;

  JewelryState copyWith(
      {JewelryStatus? status,
      List<Jewelry>? jewelryList,
      bool? hasReachedMax,
      String? previous,
      int? count,
      String? next}) {
    return JewelryState(
      count: count ?? this.count,
        status: status ?? this.status,
        jewelryList: jewelryList ?? this.jewelryList,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        previous: previous ?? this.previous,
        next: next ?? this.next);
  }

  @override
  List<Object> get props =>
      [status, jewelryList, hasReachedMax, previous, next, count];
}
