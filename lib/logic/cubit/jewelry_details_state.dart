part of 'jewelry_details_cubit.dart';

@immutable
sealed class JewelryDetailsState {}

final class JewelryDetailsInitial extends JewelryDetailsState {}

final class JewelryDetailsNotFound extends JewelryDetailsState {}

final class JewelryDetailsFailure extends JewelryDetailsState {}

final class JewelryDetailsLoaded extends JewelryDetailsState {
  final JewelryDetailsModel jewelry;
  JewelryDetailsLoaded({required this.jewelry});
}
