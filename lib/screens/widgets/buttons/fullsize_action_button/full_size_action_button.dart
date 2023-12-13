import 'package:flutter/material.dart';

class FullSizeActionButton extends StatelessWidget {
  final Widget icon;
  final Widget icon2;
  final String text;
  final VoidCallback onPressed;

  const FullSizeActionButton({
    Key? key,
    required this.icon,
    required this.icon2,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
            side: BorderSide(color: Colors.grey[200]!),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            foregroundColor: Colors.black,
            textStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500)),
        onPressed: onPressed,
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 10,
            ),
            Text(text),
            const Spacer(),
            icon2
          ],
        ),
      ),
    );
  }
}
