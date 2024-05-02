import 'dart:developer';

import 'package:earlybuddy/presentation/addschedule/addschedule.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'addschedule_event.dart';
part 'addschedule_state.dart';

class AddScheduleBloc extends Bloc<AddScheduleEvent, AddScheduleState> {
  AddScheduleBloc() : super(AddScheduleState.empty()) {
    on<AddScheduleTitleChanged>(_onAddScheduleTitleChanged);
    on<AddScheduleMemoChanged>(_onAddScheduleMemoChanged);
    on<AddScheduleTimeChanged>(_onAddScheduleTimeChanged);
    on<AddScheduleIsNotifyChanged>(_onAddScheduleIsNotifyChanged);
    on<AddSchedulePressed>(_onAddSchedulePressed);
    on<AddScheduleOnVisibleSnackBar>(_onAddScheduleOnVisibleSnackBar);
  }

  void _onAddScheduleTitleChanged(
    AddScheduleTitleChanged event,
    Emitter<AddScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        info: state.info.copyWith(
          title: event.title,
        ),
      ),
    );
  }

  void _onAddScheduleMemoChanged(
    AddScheduleMemoChanged event,
    Emitter<AddScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        info: state.info.copyWith(
          memo: event.memo,
        ),
      ),
    );
  }

  void _onAddScheduleTimeChanged(
    AddScheduleTimeChanged event,
    Emitter<AddScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        info: state.info.copyWith(
          time: event.time,
        ),
      ),
    );
  }

  void _onAddScheduleIsNotifyChanged(
    AddScheduleIsNotifyChanged event,
    Emitter<AddScheduleState> emit,
  ) {
    emit(
      state.copyWith(
        info: state.info.copyWith(
          isNotify: event.isNotify,
        ),
      ),
    );
  }

  void _onAddSchedulePressed(
    AddSchedulePressed event,
    Emitter<AddScheduleState> emit,
  ) {
    AddScheduleStatus status;
    if (state.info.title.isEmpty) {
      status = AddScheduleStatus.emptyTitle;
    } else {
      status = AddScheduleStatus.none;
    }
    var newState = state.copyWith(status: status);
    log(newState.toString());
    emit(newState);
  }

  void _onAddScheduleOnVisibleSnackBar(
    AddScheduleOnVisibleSnackBar event,
    Emitter<AddScheduleState> emit,
  ) {
    emit(state.copyWith(status: AddScheduleStatus.none));
  }
}
