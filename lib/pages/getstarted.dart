import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'register.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.zero,
        margin: EdgeInsets.zero,
        child: Stack(
          children: [
            Image.asset(
              'src/images/login_bg.png',
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.cover,
            ),
            Positioned(
                top: MediaQuery.of(context).size.height / 2.5 - 100,
                right: -90,
                child: Image.asset(
                  'src/images/asset/ellipse_green.png',
                  width: 200,
                )),
            Positioned(
                bottom: -50,
                left: -50,
                child: Image.asset(
                  'src/images/asset/ellipse_blue.png',
                  width: 200,
                )),
            Positioned(
                top: MediaQuery.of(context).size.height / 2.5,
                // width: dou,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 50, top: 30),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 36,
                              child: Text("Welcome to",
                                  style: TextStyle(
                                    color: Color(0xFF666B6A),
                                    fontSize: 27,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ),
                            SizedBox(
                              height: 53,
                              child: Text("VoteChain,",
                                  style: TextStyle(
                                    color: Color(0xFF1BA68D),
                                    fontSize: 40,
                                    fontWeight: FontWeight.w700,
                                  )),
                            )
                          ],
                        )),
                    Container(
                        padding: const EdgeInsets.only(top: 60),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) =>
                                            const Register())));
                              },
                              child: Container(
                                width: 250,
                                height: 50,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 250,
                                        height: 50,
                                        decoration: ShapeDecoration(
                                          shape: RoundedRectangleBorder(
                                            side: const BorderSide(
                                                width: 2,
                                                color: Color(0xFF54CFF6)),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Container(
                                        width: 250,
                                        height: 50,
                                        decoration: ShapeDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment(1.00, -0.06),
                                            end: Alignment(-1, 0.06),
                                            colors: [
                                              Color(0xFF31C6E7),
                                              Color(0xFF67EACA)
                                            ],
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Positioned(
                                      left: 87,
                                      top: 10,
                                      child: Text(
                                        'Register',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'login');
                                },
                                child: Container(
                                  width: 250,
                                  height: 50,
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        child: Container(
                                          width: 250,
                                          height: 50,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 2,
                                                  color: Color(0xFF54CFF6)),
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Positioned(
                                        left: 98,
                                        top: 10,
                                        child: Text(
                                          'Login',
                                          style: TextStyle(
                                            color: Color(0xFF54CFF6),
                                            fontSize: 20,
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        )),
                  ],
                )),
            Positioned(
                bottom: 50,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                    child: Text(
                      "“Your Trusted Blockchain E-Voting Platform”",
                      style: TextStyle(
                        color: Color(0xFF4D4D4D),
                        fontSize: 14,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.14,
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
