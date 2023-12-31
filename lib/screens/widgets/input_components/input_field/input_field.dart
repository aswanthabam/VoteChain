import 'package:flutter/material.dart';

class InputFieldHandler {
  late final TextEditingController controller;
  final void Function(String)? onChanged;
  final String initialValue;
  final bool secureText;
  InputFieldHandler(
      {required label,
      this.onChanged,
      this.initialValue = "",
      this.secureText = false}) {
    controller = TextEditingController(text: initialValue);
    inputField = InputField(
      label: label,
      controller: controller,
      onChanged: onChanged,
      secureText: secureText,
    );
  }

  String get text => controller.text;
  set text(String value) {
    controller.text = value;
    onChanged?.call(value);
  }

  late InputField inputField;

  void clear() {
    controller.clear();
  }

  InputField get widget => inputField;
}

class InputField extends StatefulWidget {
  const InputField({
    super.key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.secureText = false,
  });
  final String label;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final bool secureText;
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
          obscureText: widget.secureText,
          controller: widget.controller,
          onChanged: widget.onChanged,
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
