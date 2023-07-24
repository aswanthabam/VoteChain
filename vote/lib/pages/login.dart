import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../components/keyboard.dart';
import '../components/valueDisplayer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String enteredValue = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
  }

  void addValue(String val) {
    setState(() {
      if (val == "clr") {
        enteredValue = "";
      } else if (val == "bck") {
        if (enteredValue.length > 0) {
          enteredValue = enteredValue.substring(0, enteredValue.length - 1);
        }
      } else {
        enteredValue += val;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
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
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back_ios))),
        Positioned(
            right: 20,
            top: 30,
            child: IconButton(
                onPressed: () {}, icon: Icon(Icons.help_outline_outlined))),
        Positioned(
            top: 100,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Enter Your Unique Identification Number',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'A code will be sent to your registered mobile number',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.07,
                      ),
                    ),
                  ),
                  ValueDisplayer(
                      value: enteredValue,
                      length: 12,
                      divide: [4, 4, 4],
                      fill: '0'),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 30,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: enteredValue.length == 12
                            ? Color(0xff1CA78E)
                            : Color.fromARGB(170, 208, 255, 247),
                        borderRadius: BorderRadius.circular(30)),
                    child: Stack(
                      children: [
                        Expanded(
                            child: Center(
                          child: Text(
                            "Next",
                            style: TextStyle(
                              color: enteredValue.length == 12
                                  ? Color(0xffffffff)
                                  : Color(0x7C1E1E1E),
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.16,
                            ),
                          ),
                        ))
                      ],
                    ),
                  )
                ],
              ),
            )),
        Positioned(
            bottom: 0,
            child: KeyBoard(
              onPressed: (val) {
                addValue(val);
              },
              length: 12,
            ))
      ],
    ));
  }
}
