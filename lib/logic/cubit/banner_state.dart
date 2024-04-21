part of 'banner_cubit.dart';

enum Status { initial, success, failure }

final class BannerState extends Equatable {
   BannerState({this.status = Status.initial,BannerData? bannerData}): bannerData = bannerData ?? BannerData.empty;
  final Status status;
  final BannerData bannerData;

  @override
  List<Object> get props => [status, bannerData];
}
