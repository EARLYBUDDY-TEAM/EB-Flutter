import 'package:earlybuddy/_testt/presentation/home/cards/transport_card.dart';
import 'package:flutter/material.dart';

class TestShadowCard extends StatelessWidget {
  final BoxShadow shadow = const BoxShadow(
    color: Colors.black,
    offset: Offset(0, 10),
    // blurRadius: 10,
  );

  final BoxShadow customShadow = const CustomBoxShadow(
    color: Colors.black,
    offset: Offset(0, 5),
  );

  const TestShadowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.yellow.withOpacity(0.2),
        boxShadow: [
          // shadow,
          customShadow
        ],
      ),
    );
  }
}

class CustomBoxShadow extends BoxShadow {
  @override
  final BlurStyle blurStyle;

  const CustomBoxShadow({
    super.color,
    super.offset,
    super.blurRadius,
    this.blurStyle = BlurStyle.normal,
  });

  @override
  Paint toPaint() {
    final Paint result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(blurStyle, blurSigma);
    assert(() {
      if (debugDisableShadows) {
        result.maskFilter = null;
      }
      return true;
    }());
    return result;
  }
}

// class TestShadowCard extends StatelessWidget {
//   final Shadow shadow = const BoxShadow(
//     // color: Colors.grey.withOpacity(0.5),
//     color: Colors.black,
//     spreadRadius: 5,
//     blurRadius: 7,
//     offset: Offset(0, 3),
//   );

//   final Container transparentContainer = Container(
//     width: 200,
//     height: 200,
//     color: Colors.transparent,
//   );

//   TestShadowCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ClipShadowPath(
//       shadow: shadow,
//       clipper: InvertedClipper(),
//       child: Container(
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: const Content(),
//       ),
//     );
//   }
// }

class InvertedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path.combine(
      PathOperation.difference,
      Path()..addRect(Rect.fromLTWH(0, 0, size.width, size.height)),
      Path()..addRect(Rect.fromLTWH(1, 1, size.width - 5, size.height - 5)),
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

@immutable
class ClipShadowPath extends StatelessWidget {
  final Shadow shadow;
  final CustomClipper<Path> clipper;
  final Widget child;

  const ClipShadowPath({
    super.key,
    required this.shadow,
    required this.clipper,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ClipShadowShadowPainter(
        clipper: clipper,
        shadow: shadow,
      ),
      child: ClipPath(clipper: clipper, child: child),
    );
  }
}

class _ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  _ClipShadowShadowPainter({
    required this.shadow,
    required this.clipper,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
