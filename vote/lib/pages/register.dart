import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  TextEditingController _keyboardController = TextEditingController();
  FocusNode _keyboard = FocusNode();
  // final FocusNode _keyboardFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    // _keyboardController.addListener(_limitInputLength);
  }

  void _limitInputLength() {
    if (_keyboardController.text.length > keyboardLength) {
      _keyboardController.text =
          _keyboardController.text.substring(0, keyboardLength);
      _keyboardController.selection = TextSelection.fromPosition(
          TextPosition(offset: _keyboardController.text.length));
    }
  }

  void showNumKeyboard(int size) {
    setState(() {
      displayIntKeyboard = true;
      // keyboardReset = !keyboardReset;
      keyboardLength = size;
    });

    // FocusScope.of(context).requestFocus(_keyboard);
    // SystemChannels.textInput.invokeMethod("TextInput.hide");
  }

  void hideNumKeyboard() {
    setState(() {
      displayIntKeyboard = false;
    });
    // FocusScope.of(context).requestFocus(_keyboard);
    // SystemChannels.textInput.invokeMethod("TextInput.hide");
  }

  void showAlphaKeyboard(int size) {
    // if (displayIntKeyboard) {
    setState(() {
      displayIntKeyboard = false;
      keyboardLength = size;
    });
    // }
    // if (MediaQuery.of(context).viewInsets.bottom <= 0) {
    FocusScope.of(context).requestFocus(_keyboard);
    // Future.delayed(Duration(seconds: 1), () {
    //   SystemChannels.textInput.invokeMethod("TextInput.show");
    // });
    // }
  }

  void hideAlphaKeyboard() {
    _keyboard.unfocus();
    // SystemChannels.textInput.invokeMethod("TextInput.hide");
  }

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
        case 2:
          if (val.isNotEmpty) {
            password = val;
          }
          break;
      }
    });
  }

  Widget getCurrentWidget() {
    switch (step) {
      case 0:
        // print("UID : $uid\nOTP : $otp\nPassword: $password");
        showNumKeyboard(12);
        return UID(
          value: uid,
        );
      case 1:
        // print("UID : $uid\nOTP : $otp\nPassword: $password");
        hideNumKeyboard();
        return OTP(
          value: otp,
          onInputClick: () {
            print("Open");
            showAlphaKeyboard(6);
          },
        );
      case 2:
        // print("UID : $uid\nOTP : $otp\nPassword: $password");
        hideNumKeyboard();
        hideAlphaKeyboard();
        return Password(
          onChange: (val) {
            print(password + ",Validate : " + validate().toString());
            setValue(val);
          },
        );
      default:
        return const Expanded(
          child: SizedBox(),
        );
    }
  }

  void clearStep() {
    print("Clear");
    switch (step) {
      case 0:
        setState(() {
          uid = "";
          keyboardLength = 0;
          // keyboardReset = !keyboardReset;
        });
      case 1:
        setState(() {
          otp = "";
          keyboardLength = 12;
          _keyboardController.text = "";
          // keyboardReset = !keyboardReset;
        });
      case 2:
        setState(() {
          password = "";
          keyboardLength = 6;
          // keyboardReset = !keyboardReset;
        });
    }
  }

  void nextStep() {
    if (step < totalstep - 1) {
      setState(() {
        step++;
      });
    }
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
                  print("Submiting...");
                  if (validate()) {
                    if (step == totalstep - 1) {
                      print("Submit");
                      hideAlphaKeyboard();
                      setState(() {
                        // buttonEnabled = false;
                        buttonProcessing = true;
                      });
                      await Global.linker.requestEthers(context);
                      var st = await Global.linker
                          .register("TEst", int.parse(uid), context);
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
                      print("Valid");
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
