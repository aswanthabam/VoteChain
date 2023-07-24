import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned(
        top: -100,
        left: MediaQuery.of(context).size.width / 2 - 100,
        child: Image.asset('src/images/asset/ellipse_green.png', width: 200),
      ),
      Positioned(
        bottom: -50,
        right: -50,
        child: Image.asset('src/images/asset/ellipse_blue.png', width: 200),
      ),
      Positioned(
          top: 150,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Image.asset('src/images/asset/circle_rounded_blue.png',
                        width: 20, height: 20),
                    Container(
                      width: 20,
                      height: 20,
                      child: Center(
                          child: Text(
                        '1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.08,
                        ),
                      )),
                    )
                  ],
                ),
                Container(
                    height: 20,
                    child: Center(
                      child: Image.asset('src/images/asset/line_dashed.png'),
                    )),
                Stack(
                  children: [
                    Image.asset(
                        'src/images/asset/circle_rounded_double_blue.png',
                        width: 20,
                        height: 20),
                    Container(
                      width: 20,
                      height: 20,
                      child: Center(
                          child: Text(
                        '2',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.08,
                        ),
                      )),
                    )
                  ],
                ),
                Container(
                    height: 20,
                    child: Center(
                      child: Image.asset('src/images/asset/line_dashed.png'),
                    )),
                Stack(
                  children: [
                    Image.asset(
                        'src/images/asset/circle_rounded_double_blue.png',
                        width: 20,
                        height: 20),
                    Container(
                      width: 20,
                      height: 20,
                      child: Center(
                          child: Text(
                        '3',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.08,
                        ),
                      )),
                    )
                  ],
                ),
              ],
            ),
          ))
    ]));
  }
}
