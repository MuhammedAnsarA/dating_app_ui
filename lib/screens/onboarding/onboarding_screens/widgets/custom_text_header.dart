import 'package:flutter/material.dart';

class CustomTextHeader extends StatelessWidget {
  final String text;

  const CustomTextHeader({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
    );
  }
}
