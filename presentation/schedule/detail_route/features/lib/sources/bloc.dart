part of '../eb_detail_route_feature.dart';

class DetailRouteBloc extends Bloc<DetailRouteEvent, DetailRouteState> {
  DetailRouteBloc({
    required EBPath ebPath,
  }) : super(DetailRouteState(ebPath: ebPath));
}
