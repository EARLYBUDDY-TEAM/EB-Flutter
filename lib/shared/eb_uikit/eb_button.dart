import 'package:flutter/material.dart';
import 'package:earlybuddy/shared/assets/font.dart';

class EBButton extends StatelessWidget {
  final String name;
  final VoidCallback? onPressed;

  const EBButton({
    super.key,
    required this.name,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        shadowColor: Colors.black87,
        textStyle: const TextStyle(
          fontFamily: NanumSquare.bold,
          fontSize: 20,
        ),
        padding: const EdgeInsets.all(10),
        minimumSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(name),
    );
  }
}