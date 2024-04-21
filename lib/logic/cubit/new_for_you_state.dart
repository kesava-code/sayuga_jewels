part of 'new_for_you_cubit.dart';

enum NewForYouStatus { initial, success, failure }

final class NewForYouState extends Equatable {
  const NewForYouState( 
      {this.status = NewForYouStatus.initial,
      this.jewelryList = const <Jewelry>[],
      });
  final NewForYouStatus status;
  final List<Jewelry> jewelryList;

  NewForYouState copyWith(
      {NewForYouStatus? status,
      List<Jewelry>? jewelryList,
     }) {
    return NewForYouState(
     
        status: status ?? this.status,
        jewelryList: jewelryList ?? this.jewelryList,
       );
  }

  @override
  List<Object> get props =>
      [status, jewelryList];
}

