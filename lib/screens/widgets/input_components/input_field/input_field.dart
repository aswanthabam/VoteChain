import 'package:flutter/material.dart';

class InputFieldHandler {
  late final TextEditingController controller;
  InputFieldHandler({required label}) {
    controller = TextEditingController();
    inputField = InputField(label: label, controller: controller);
  }
  String get text => controller.text;
  set text(String value) => controller.text = value;
  late InputField inputField;

  void clear() {
    controller.clear();
  }

  InputField get widget => inputField;
}

class InputField extends StatefulWidget {
  const InputField({super.key, required this.label, required this.controller});
  final String label;
  final TextEditingController controller;
  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(68, 27, 166, 141),
            borderRadius: BorderRadius.circular(20)),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              border: InputBorder.none,
              labelText: widget.label,
              labelStyle: const TextStyle(
                  color: Color(0xff4e4e4e),
                  fontSize: 14,
                  fontWeight: FontWeight.w500)),
        ));
  }
}