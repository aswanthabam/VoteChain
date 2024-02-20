import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClick;

  const IconButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ButtonStyle(
            padding: MaterialStateProperty.all(
                const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5)),
            backgroundColor: MaterialStateProperty.all(
                const Color.fromARGB(153, 15, 171, 18)),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            textStyle:
                MaterialStateProperty.all(const TextStyle(fontSize: 13))),
        onPressed: onClick,
        icon: Icon(icon),
        label: Text(text),
      ),
    );
  }
}
