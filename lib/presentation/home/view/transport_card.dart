part of 'home_view.dart';

class TransportCard extends StatelessWidget {
  const TransportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const _TransportCardContent(),
    );
  }
}

class _TransportCardContent extends StatelessWidget {
  const _TransportCardContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      child: Text(
                        '강남06',
                        style: TextStyle(
                          fontFamily: NanumSquare.bold,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    '삼성의료원 후문',
                    style: TextStyle(
                      fontFamily: NanumSquare.regular,
                      color: Colors.black87,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Text(
                '버스 도착까지',
                style: TextStyle(
                  fontFamily: GmarketSans.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  Text(
                    '약속장소에 ',
                    style: TextStyle(
                      fontFamily: GmarketSans.regular,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    '14:20',
                    style: TextStyle(
                      fontFamily: GmarketSans.bold,
                      color: Colors.blue,
                    ),
                  ),
                  Text(
                    ' 도착 예정',
                    style: TextStyle(
                      fontFamily: GmarketSans.regular,
                      color: Colors.black87,
                    ),
                  ),
                ],
              )
            ],
          ),
          const Column(
            children: [
              Text(
                '12분 전',
                style: TextStyle(
                  fontFamily: GmarketSans.bold,
                  fontSize: 35,
                ),
              ),
              Text(
                '다음 배차까지 25분전',
                style: TextStyle(
                  fontFamily: NanumSquare.regular,
                  color: Colors.black87,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


// class TestCard extends StatelessWidget {
//   const TestCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ClipRect(
//       clipBehavior: Clip.antiAlias,
//       child: BackdropFilter(
//         filter: ImageFilter.blur(
//           sigmaX: 10.0,
//           sigmaY: 10.0,
//         ),
//         child: Container(
//           height: 150,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade200.withOpacity(0.5),
//             borderRadius: BorderRadius.circular(15),
//           ),
//           child: const Center(
//             child: Text(
//               'Frosted',
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

