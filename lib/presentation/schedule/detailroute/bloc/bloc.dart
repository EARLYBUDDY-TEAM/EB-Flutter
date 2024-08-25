import 'package:earlybuddy/shared/eb_model/entity/entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'event.dart';
part 'state.dart';

class DetailRouteBloc extends Bloc<DetailRouteEvent, DetailRouteState> {
  DetailRouteBloc({
    required EBPath ebPath,
  }) : super(DetailRouteState(ebPath: ebPath));
}
