import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/keyboard.dart';
import '../components/uid.dart';
import '../components/otp.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int step = 0;
  String uid = "";
  String otp = "";

  bool displayIntKeyboard = false, keyboardReset = false;
  int keyboardLength = 12;
  TextEditingController _keyboardController = TextEditingController();
  FocusNode _keyboard = FocusNode();
  // final FocusNode _keyboardFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  String getCurrentValue() {
    switch (step) {
      case 0:
        return uid;
      case 1:
        return otp;
      default:
        return "";
    }
  }

  void addValue(String val, int step) {
    String tmp = getCurrentValue();
    if (val == "clr") {
      tmp = "";
    } else if (val == "bck") {
      if (tmp.isNotEmpty) {
        tmp = tmp.substring(0, tmp.length - 1);
      }
    } else {
      tmp += val;
    }
    setValue(tmp);
  }

  void setValue(String val) {
    setState(() {
      switch (step) {
        case 0:
          uid = val;
          break;
        case 1:
          if (val.length <= 6) {
            otp = val;
          }
          break;
      }
    });
  }

  Widget getCurrentWidget(int s) {
    switch (s) {
      case 0:
        setState(() {
          displayIntKeyboard = true;
        });
        return UID(
          value: uid,
        );
      case 1:
        setState(() {
          displayIntKeyboard = false;
          keyboardLength = 6;
          // keyboardReset = !keyboardReset;
        });
        FocusScope.of(context).requestFocus(_keyboard);
        SystemChannels.textInput.invokeMethod("TextInput.show");
        // Syste
        // TextInput.
        return OTP(
          value: otp,
        );
      default:
        return const Expanded(
          child: SizedBox(),
        );
    }
  }

  void nextStep() {
    setState(() {
      step++;
    });
  }

  bool preStep() {
    if (step > 0) {
      setState(() {
        step--;
      });
      return true;
    } else {
      return false;
    }
  }

  bool validate() {
    switch (step) {
      case 0:
        if (uid.length == 12) {
          return true;
        } else {
          return false;
        }
      case 1:
        if (otp.length == 6) {
          return true;
        } else {
          return false;
        }
      default:
        return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
          top: -100,
          right: -100,
          child: Image.asset(
            'src/images/asset/ellipse_green.png',
            width: 200,
          )),
      Positioned(
          left: 20,
          top: 30,
          child: IconButton(
              onPressed: () {
                if (!preStep()) Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios))),
      Positioned(
          right: 20,
          top: 30,
          child: IconButton(
              onPressed: () {}, icon: const Icon(Icons.help_outline_outlined))),
      Positioned(
          top: 100,
          child: Column(
            children: [
              getCurrentWidget(step),
              TextButton(
                onPressed: () {
                  print("Submiting...");
                  if (validate()) {
                    print("Valid");
                    nextStep();
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 30,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: validate()
                          ? const Color(0xff1CA78E)
                          : const Color.fromARGB(170, 208, 255, 247),
                      borderRadius: BorderRadius.circular(30)),
                  child: Stack(
                    children: [
                      Expanded(
                          child: Center(
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: validate()
                                ? const Color(0xffffffff)
                                : const Color(0x7C1E1E1E),
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.16,
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
              )
            ],
          )),
      Positioned(
          bottom: 0,
          child: displayIntKeyboard
              ? KeyBoard(
                  onPressed: (val) {
                    addValue(val, step);
                  },
                  length: keyboardLength,
                  reset: keyboardReset,
                )
              : SizedBox(
                  width: 0,
                  height: 0,
                  child: RawKeyboardListener(
                    focusNode: _keyboard,
                    onKey: (RawKeyEvent event) {
                      if (event is RawKeyDownEvent) {
                        if (event.logicalKey.keyLabel.isNotEmpty) {
                          addValue(event.character!, step);
                        }
                      }
                    },
                    child: TextFormField(
                      controller: _keyboardController,
                      autofocus: true,
                    ),
                  ))),
    ]));
  }
}
