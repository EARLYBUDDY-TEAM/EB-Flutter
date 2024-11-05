part of '../../entity.dart';

final class SchedulePath extends Equatable {
  final Schedule schedule;
  final EBPath? ebPath;

  const SchedulePath({
    required this.schedule,
    this.ebPath,
  });

  SchedulePath copyWith({
    Schedule? schedule,
    EBPath? Function()? ebPath,
  }) {
    return SchedulePath(
      schedule: schedule ?? this.schedule,
      ebPath: (ebPath != null) ? ebPath() : this.ebPath,
    );
  }

  SchedulePath.fromDTO({
    required SchedulePathDTO dto,
  })  : schedule = Schedule.fromDTO(scheduleDTO: dto.scheduleDTO),
        ebPath = (dto.ebPathDTO != null)
            ? EBPath.fromDTO(ebPathDTO: dto.ebPathDTO!)
            : null;

  SchedulePathDTO toDTO() {
    return SchedulePathDTO(
      scheduleDTO: schedule.toDTO(),
      ebPathDTO: ebPath?.toDTO(),
    );
  }

  @override
  List<Object?> get props => [
        schedule,
        ebPath,
      ];
}
