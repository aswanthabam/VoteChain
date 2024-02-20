import 'package:flutter/material.dart';

typedef OnBottomButtonPress = void Function(int);

class TextPopup extends StatelessWidget {
  final String message;
  final List<Widget> bottomButtons;
  final OnBottomButtonPress? onBottomButtonPress;

  const TextPopup({
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
              const EdgeInsets.only(top: 20, bottom: 5, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // IconButton(
              //     onPressed: () {
              //       Navigator.pop(context);
              //     },
              //     icon: Icon(
              //       Icons.close,
              //       size: 20,
              //     )),
              const SizedBox(height: 10.0),
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
