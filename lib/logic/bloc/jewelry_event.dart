part of 'jewelry_bloc.dart';

sealed class JewelryEvent extends Equatable {
  const JewelryEvent();

  @override
  List<Object> get props => [];
}
final class JewelryFetched extends JewelryEvent {}
