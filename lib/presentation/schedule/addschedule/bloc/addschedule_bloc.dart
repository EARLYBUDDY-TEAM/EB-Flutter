import 'package:earlybuddy/domain/delegate/searchplace_event_delegate.dart';
import 'package:earlybuddy/domain/repository/searchplace/source/model/model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'addschedule_event.dart';
part 'addschedule_state.dart';

class AddScheduleBloc extends Bloc<AddScheduleEvent, AddScheduleState> {
  final VoidCallback _popSearchPlaceView;

  AddScheduleBloc({
    VoidCallback? popSearchPlaceView,
  })  : _popSearchPlaceView = popSearchPlaceView ?? (() {}),
        super(AddScheduleState.empty()) {
    on<AddScheduleTitleChanged>(_onAddScheduleTitleChanged);
    on<AddScheduleMemoChanged>(_onAddScheduleMemoChanged);
    on<AddScheduleTimeChanged>(_onAddScheduleTimeChanged);
    on<AddScheduleIsNotifyChanged>(_onAddScheduleIsNotifyChanged);
    on<AddSchedulePressed>(_onAddSchedulePressed);

    on<AddScheduleInfoPlaceChanged>(_onAddScheduleInfoPlaceChanged);
    SearchPlaceEventDelegate.shared.selectPlaceButtonPressed.listen(
      (selectedPlace) => add(AddScheduleInfoPlaceChanged(place: selectedPlace)),
    );
    SearchPlaceEventDelegate.shared.cancelButtonPressed.listen(
      (event) => _popSearchPlaceView(),
    );
  }
}

extension on AddScheduleBloc {
  void _onAddScheduleTitleChanged(
    AddScheduleTitleChanged event,
    Emitter<AddScheduleState> emit,
  ) {
    final title = event.title.trim();
    final newInfo = state.info.copyWith(title: title);
    final newStatus = title.isEmpty
        ? AddScheduleStatus.inComplete
        : AddScheduleStatus.complete;
    emit(state.copyWith(
      info: newInfo,
      status: newStatus,
    ));
  }
}

extension on AddScheduleBloc {
  void _onAddScheduleMemoChanged(
    AddScheduleMemoChanged event,
    Emitter<AddScheduleState> emit,
  ) {
    final memo = event.memo.trim();
    final newInfo = state.info.copyWith(memo: memo);
    emit(state.copyWith(info: newInfo));
  }
}

extension on AddScheduleBloc {
  void _onAddScheduleTimeChanged(
    AddScheduleTimeChanged event,
    Emitter<AddScheduleState> emit,
  ) {
    final newInfo = state.info.copyWith(time: event.time);
    emit(state.copyWith(info: newInfo));
  }
}

extension on AddScheduleBloc {
  void _onAddScheduleIsNotifyChanged(
    AddScheduleIsNotifyChanged event,
    Emitter<AddScheduleState> emit,
  ) {
    final newInfo = state.info.copyWith(isNotify: event.isNotify);
    emit(state.copyWith(info: newInfo));
  }
}

extension on AddScheduleBloc {
  void _onAddSchedulePressed(
    AddSchedulePressed event,
    Emitter<AddScheduleState> emit,
  ) {
    emit(state);
  }
}

extension on AddScheduleBloc {
  void _onAddScheduleInfoPlaceChanged(
    AddScheduleInfoPlaceChanged event,
    Emitter<AddScheduleState> emit,
  ) {
    final AddScheduleInfo info = state.info.copyWith(place: event.place.name);
    emit(state.copyWith(info: info));
    _popSearchPlaceView();
  }
}
