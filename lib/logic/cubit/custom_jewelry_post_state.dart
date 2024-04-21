part of 'custom_jewelry_post_cubit.dart';

sealed class CustomJewelryPostState extends Equatable {
  const CustomJewelryPostState();

  @override
  List<Object> get props => [];
}

final class CustomJewelryPostInitial extends CustomJewelryPostState {}
final class CustomJewelryPostUploading extends CustomJewelryPostState {}
final class CustomJewelryPostUploaded extends CustomJewelryPostState {}
final class CustomJewelryPostFailure extends CustomJewelryPostState{}
