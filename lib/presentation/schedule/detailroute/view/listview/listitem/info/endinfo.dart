part of '../../../detailroute_view.dart';

final class _EndInfo extends StatelessWidget {
  final EBSubPath ebSubPath;

  const _EndInfo({
    super.key,
    required this.ebSubPath,
  });

  @override
  Widget build(BuildContext context) {
    switch (ebSubPath.type) {
      case (1):
        return _EndInfoItem.subway(ebSubPath.endName);
      case (2):
        return _EndInfoItem.bus(ebSubPath.endName);
      default:
        return _EndInfoItem.walk(ebSubPath.endName);
    }
  }
}

final class _EndInfoItem extends StatelessWidget {
  final List<Widget> rowChildren;

  const _EndInfoItem({
    super.key,
    required this.rowChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: rowChildren,
    );
  }

  factory _EndInfoItem.walk(String endName) {
    final text = '$endName까지 걷기';
    return _EndInfoItem(
      rowChildren: [
        Text(
          text,
          style: const TextStyle(
            fontFamily: NanumSquare.bold,
            fontSize: 20,
          ),
        )
      ],
    );
  }

  factory _EndInfoItem.bus(String endName) {
    return _EndInfoItem(
      rowChildren: [
        Text(
          endName,
          style: const TextStyle(
            fontFamily: NanumSquare.bold,
            fontSize: 20,
          ),
        )
      ],
    );
  }

  factory _EndInfoItem.subway(String endName) {
    return _EndInfoItem(
      rowChildren: [
        Text(
          endName,
          style: const TextStyle(
            fontFamily: NanumSquare.bold,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}

// Row endInfo() {
//     var text = ebSubPath.endName;
//     if (ebSubPath.type == 3) {
//       text += '까지 걷기';
//     }
//     return Row(
//       children: [
//         Text(
//           text,
//           style: TextStyle(
//             fontFamily: NanumSquare.regular,
//             fontSize: 18,
//             color: EBColors.text,
//           ),
//         ),
//       ],
//     );
//   }
