import 'package:flutter/material.dart';
import 'package:earlybuddy/shared/assets/color.dart';

class WaveBackground extends StatelessWidget {
  const WaveBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        WaveBackground1(),
        WaveBackground2(),
      ],
    );
  }
}

class WaveBackground2 extends StatelessWidget {
  const WaveBackground2({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper2(),
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              EBColors.purple2.withOpacity(0.3),
              EBColors.blue1.withOpacity(0.3),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
          ),
        ),
      ),
    );
  }
}

class WaveClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double waveHeight = size.height / 3;
    double dist = 30 + 5;
    double firstWaveWidth = size.width / 2.5;
    double secondWaveWidth = size.width - firstWaveWidth;

    path.lineTo(0, waveHeight + 20);
    var firstControlPoint = Offset(firstWaveWidth / 1.7, waveHeight + dist);
    var firstEndPoint = Offset(firstWaveWidth, waveHeight + (dist / 2));
    var secondControlPoint = Offset(
        firstWaveWidth + (secondWaveWidth / 1.8), waveHeight - dist + 10);
    var secondEndPoint = Offset(size.width, waveHeight - 40);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}

// Center
class WaveBackground1 extends StatelessWidget {
  const WaveBackground1({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: WaveClipper1(),
      clipBehavior: Clip.hardEdge,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              EBColors.purple2.withOpacity(0.7),
              EBColors.blue1.withOpacity(0.7),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
    );
  }
}

class WaveClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    double waveHeight = size.height / 3;
    double dist = 30;
    double firstWaveWidth = size.width / 2.5;
    double secondWaveWidth = size.width - firstWaveWidth;

    path.lineTo(0, waveHeight);
    var firstControlPoint = Offset(firstWaveWidth / 1.7, waveHeight + dist);
    var firstEndPoint = Offset(firstWaveWidth, waveHeight + (dist / 2));
    var secondControlPoint = Offset(
        firstWaveWidth + (secondWaveWidth / 1.8), waveHeight - dist + 10);
    var secondEndPoint = Offset(size.width, waveHeight + 5);

    path.quadraticBezierTo(
      firstControlPoint.dx,
      firstControlPoint.dy,
      firstEndPoint.dx,
      firstEndPoint.dy,
    );
    path.quadraticBezierTo(
      secondControlPoint.dx,
      secondControlPoint.dy,
      secondEndPoint.dx,
      secondEndPoint.dy,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
