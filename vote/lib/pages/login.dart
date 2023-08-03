import 'package:flutter/material.dart';
import '../components/keyboard.dart';
import '../components/uid.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  int step = 0;
  String uid = "";
  void addUID(String val) {
    setState(() {
      if (val == "clr") {
        uid = "";
      } else if (val == "bck") {
        if (uid.isNotEmpty) {
          uid = uid.substring(0, uid.length - 1);
        }
      } else {
        uid += val;
      }
    });
  }

  Widget getCurrentWidget(int s) {
    switch (s) {
      case 0:
        return UID(
          value: uid,
        );
      case 1:
        return const Text("NEXT");
      default:
        return const Placeholder();
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
    if (step == 0) {
      if (uid.length == 12) {
        return true;
      } else {
        return false;
      }
    } else {
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
                  if (validate()) {
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
                      Row(
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
                          )),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
      Positioned(
          bottom: 0,
          child: KeyBoard(
            onPressed: (val) {
              addUID(val);
            },
            length: 12,
          ))
    ]));
  }
}
