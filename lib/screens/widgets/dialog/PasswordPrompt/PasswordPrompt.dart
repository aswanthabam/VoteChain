import 'package:flutter/material.dart';

typedef OnBottomButtonPress = void Function(int);

class PasswordPrompt extends StatelessWidget {
  final String message;
  final List<Widget> bottomButtons;
  final OnBottomButtonPress? onBottomButtonPress;

  const PasswordPrompt({
    Key? key,
    required this.message,
    this.bottomButtons = const [],
    this.onBottomButtonPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
              const SizedBox(height: 20.0),
              Text(message, style: const TextStyle(fontSize: 13)),
              SizedBox(
                height: 60,
                width: 200,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ...bottomButtons.map((button) {
                      return Row(children: [
                        button,
                        const SizedBox(
                          width: 10,
                        )
                      ]);
                    }),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
