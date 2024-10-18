part of '../../../eb_add_schedule.dart';

final class StartPlaceExpanded extends StatelessWidget {
  const StartPlaceExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _divider(),
        _requiredTime(),
        _transportLine(),
        _expectStartTime(),
        _endPlaceInfo(address: "강남구"),
      ],
    );
  }

  Widget _divider() {
    return const Divider(
      color: Colors.grey,
      thickness: 0.5,
    );
  }

  Widget _requiredTime() {
    return const Row(
      children: [
        Text(
          "1시간 30분",
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: 20,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "버스 + 지하철",
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        Spacer(),
        EBRoundedButton(text: "경로 변경"),
      ],
    );
  }

  Widget _transportLine() {
    return const Text("trnasportline");
  }

  Widget _expectStartTime() {
    return const Row(
      children: [
        Text(
          "출발예정 : ",
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareRegular,
            fontSize: 13,
            color: Colors.black45,
          ),
        ),
        Text(
          "약 10시 50분",
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _endPlaceInfo({
    required String address,
  }) {
    return Row(
      children: [
        const Text(
          "출발장소 : ",
          style: TextStyle(
            fontFamily: FontFamily.nanumSquareRegular,
            fontSize: 13,
            color: Colors.black45,
          ),
        ),
        Text(
          address,
          style: const TextStyle(
            fontFamily: FontFamily.nanumSquareBold,
            fontSize: 16,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
