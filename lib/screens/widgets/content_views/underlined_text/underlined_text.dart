import 'package:flutter/material.dart';

class UnderlinedText extends StatelessWidget {
  final String heading;
  final double fontSize;
  final Color color;
  final Color underlineColor;
  final double underlineWidth;
  final double underlineHeight;
  final bool center;
  const UnderlinedText({
    super.key,
    required this.heading,
    required this.fontSize,
    required this.color,
    required this.underlineColor,
    required this.underlineWidth,
    required this.underlineHeight,
    this.center = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          center ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(
              fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Container(
          height: 2,
          width: underlineWidth,
          color: underlineColor,
        ),
        const SizedBox(height: 20)
      ],
    );
  }
}
