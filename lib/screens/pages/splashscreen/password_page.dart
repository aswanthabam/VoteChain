import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/input_components/keyboard.dart';
import 'package:vote/screens/widgets/input_components/valueDisplayer.dart';

class PasswordPage extends StatefulWidget {
  final Future<bool> Function(String) onPasswordSubmit;
  const PasswordPage({Key? key, required this.onPasswordSubmit})
      : super(key: key);
  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  String pin = "";
  int pinLength = 6;
  bool pinValid = false;
  Future<bool> onSubmit() async {
    if (pinValid) {
      return widget.onPasswordSubmit(pin);
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).viewPadding.top + 20,
          bottom: 5,
          left: 10,
          right: 10),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.lock_outline,
              size: 50,
              color: Colors.grey[800],
            ),
            const SizedBox(height: 20),
            const Text("Enter Your Pin",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Enter your pin to enter into, votechain!"),
            const SizedBox(height: 20),
            ValueDisplayer(
              value: pin,
              length: pinLength,
              divide: const [1, 1, 1, 1, 1, 1],
              fill: '-',
            ),
            const SizedBox(height: 20),
            pinValid
                ? getMinimalAsyncButton(
                    context,
                    onSubmit,
                    "Continue",
                    "Try Again",
                    "Verifying",
                    "Success",
                    pinValid
                        ? const Color.fromARGB(255, 23, 177, 64)
                        : Colors.grey,
                    Colors.white,
                    double.infinity)
                : const SizedBox(),
            const Spacer(),
            KeyBoard(onPressed: (String val) {
              setState(() {
                if (val == 'bck') {
                  if (pin.isNotEmpty) {
                    pin = pin.substring(0, pin.length - 1);
                  }
                } else if (val == 'clr') {
                  pin = "";
                } else if (pin.length < pinLength) {
                  pin += val;
                }
                if (pin.length == pinLength) {
                  pinValid = true;
                }
              });
            })
          ],
        ),
      ),
    ));
  }
}
