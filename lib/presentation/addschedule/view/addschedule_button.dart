part of 'addschedule_view.dart';

class _AddScheduleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
      child: BlocBuilder<AddScheduleBloc, AddScheduleState>(
        builder: (context, state) {
          return EBButton(
            name: '일정 등록',
            onPressed: state.status == AddScheduleStatus.complete
                ? () {
                    context
                        .read<AddScheduleBloc>()
                        .add(const AddSchedulePressed());
                  }
                : null,
          );
        },
      ),
    );
  }
}
