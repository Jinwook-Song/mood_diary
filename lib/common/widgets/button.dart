import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  const Button({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(36),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 1,
              blurRadius: 0.1,
              offset: Offset(2, 2),
            ),
          ],
          color: Colors.pink.shade100),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
