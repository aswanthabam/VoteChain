// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import '../components/keyboard.dart';
import '../components/dialog.dart';
import '../components/uid.dart';
import '../components/otp.dart';
import '../components/password.dart';
import '../classes/global.dart';
import '../classes/api.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  int step = 0, totalstep = 3;
  String uid = "";
  String otp = "";
  String password = "";

  bool displayIntKeyboard = false, keyboardReset = false;
  bool buttonEnabled = true, buttonProcessing = false;
  int keyboardLength = 12;
  final TextEditingController _keyboardController = TextEditingController();
  final FocusNode _keyboard = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  /* Show the numeric keyboard */
  void showNumKeyboard(int size) {
    setState(() {
      displayIntKeyboard = true;
      keyboardLength = size;
    });
  }

  /* Hide the numeric keyboard */
  void hideNumKeyboard() {
    setState(() {
      displayIntKeyboard = false;
    });
  }

  /* Show the alpha numeric keyboard */
  void showAlphaKeyboard(int size) {
    setState(() {
      displayIntKeyboard = false;
      keyboardLength = size;
    });
    FocusScope.of(context).requestFocus(_keyboard);
  }

  /* Hide alpha numeric keyboard */
  void hideAlphaKeyboard() {
    _keyboard.unfocus();
  }

  /* Get the current value entered by the user (Eg : otp if user is entering otp) */
  String getCurrentValue() {
    switch (step) {
      case 0:
        return uid;
      case 1:
        return otp;
      case 2:
        return password;
      default:
        return "";
    }
  }

  /* Add value to the current value 
    Character by character adding */
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

  /* Set the value of current entering value directly */
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
        case 2:
          if (val.isNotEmpty) {
            password = val;
          }
          break;
      }
    });
  }

  /* Get the current widget
    Eg : OTP widget if in the otp entering step */
  Widget getCurrentWidget() {
    switch (step) {
      case 0:
        showNumKeyboard(12);
        return UID(
          value: uid,
        );
      case 1:
        hideNumKeyboard();
        return OTP(
          value: otp,
          onInputClick: () {
            showAlphaKeyboard(6);
          },
        );
      case 2:
        hideNumKeyboard();
        hideAlphaKeyboard();
        return Password(
          onChange: (val) {
            setValue(val);
          },
        );
      default:
        return const Expanded(
          child: SizedBox(),
        );
    }
  }

  /* Clear the value of the current step */
  void clearStep() {
    switch (step) {
      case 0:
        setState(() {
          uid = "";
          keyboardLength = 0;
        });
      case 1:
        setState(() {
          otp = "";
          keyboardLength = 12;
          _keyboardController.text = "";
        });
      case 2:
        setState(() {
          password = "";
          keyboardLength = 6;
        });
    }
  }

  /* Go to te next step 
    just increment the step value the view will be automatically re rendered */
  void nextStep() {
    if (step < totalstep - 1) {
      setState(() {
        step++;
      });
    }
  }

  /* Go to previous step */
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

  /* Validate the entered value 
    Validate using the current step on which the user is on */
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
      case 2:
        if (password.length > 7 &&
            RegExp(r'[a-z]').hasMatch(password) &&
            RegExp(r'[A-Z]').hasMatch(password) &&
            RegExp(r'[0-9]').hasMatch(password)) {
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
                clearStep();
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
              getCurrentWidget(),
              TextButton(
                onPressed: () async {
                  if (validate()) {
                    if (step == totalstep - 1) {
                      hideAlphaKeyboard();
                      setState(() {
                        // buttonEnabled = false;
                        buttonProcessing = true;
                      });
                      await Global.linker.requestEthers(
                          onSuccess: (val) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Center(child: Text(val))
                                            ]))));
                          },
                          onError: (val) {});
                      var st = await Global.linker
                          .register("TEst", int.parse(uid), onError: (val) {
                        showDialog(
                            context: context,
                            builder: ((context) => MsgDialog(
                                icon: Icons.error_outline,
                                iconColor: Colors.red,
                                iconSize: 30,
                                text:
                                    "An Unexpected error occured while creating account")));
                      });
                      if (st) {
                        var value = await API.registerUser(
                            (await Global.linker.getAddress()).toString(),
                            int.parse(uid),
                            password);
                        if (value) {
                          Global.linker
                              .saveWallet("Test", int.parse(uid), password);
                          showDialog(
                              context: context,
                              builder: ((context) => MsgDialog(
                                  icon: Icons.done_rounded,
                                  iconColor: Colors.green.shade400,
                                  iconSize: 30,
                                  text: "Created Account Successfully")));
                          Navigator.pushReplacementNamed(context, 'home');
                        } else {
                          showDialog(
                              context: context,
                              builder: ((context) => MsgDialog(
                                  icon: Icons.error_outline_rounded,
                                  iconColor: Colors.red,
                                  iconSize: 30,
                                  text:
                                      "An Unexpected error occured while creating account")));
                        }
                      } else {
                        showDialog(
                            context: context,
                            builder: ((context) => MsgDialog(
                                icon: Icons.error_outline_rounded,
                                iconColor: Colors.red,
                                iconSize: 30,
                                text:
                                    "An Unexpected error occured while creating account, please try again")));
                      }
                      setState(() {
                        // buttonEnabled = false;
                        buttonProcessing = false;
                      });
                    } else {
                      nextStep();
                    }
                  }
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 30,
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: validate() && buttonEnabled
                          ? const Color(0xff1CA78E)
                          : const Color.fromARGB(170, 208, 255, 247),
                      borderRadius: BorderRadius.circular(30)),
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(width: 16),
                                Text(
                                  step == totalstep - 1 ? "Submit" : "Next",
                                  style: TextStyle(
                                    color: validate() && buttonEnabled
                                        ? const Color(0xffffffff)
                                        : const Color(0x7C1E1E1E),
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.16,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: buttonProcessing
                                      ? const CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 3,
                                        )
                                      : const SizedBox(),
                                )
                              ],
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
          child: displayIntKeyboard
              ? KeyBoard(
                  onPressed: (val) {
                    addValue(val, step);
                  },
                  length: keyboardLength,
                  reset: keyboardReset,
                  curLength: getCurrentValue().length)
              : Opacity(
                  opacity: 0,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    // height: 10,
                    child: TextFormField(
                      focusNode: _keyboard,
                      controller: _keyboardController,
                      maxLength: keyboardLength,
                      cursorHeight: 0,
                      // enabled: false,
                      onChanged: (val) {
                        if (val.length <= keyboardLength) setValue(val);
                      },
                      style: const TextStyle(color: Colors.transparent),
                      // autofocus: true,
                    ),
                  ),
                )),
    ]));
  }
}
