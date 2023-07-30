import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vote/classes/preferences.dart';
import '../classes/contract_linker.dart';
import '../classes/global.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen(
      {super.key}); //, required this.function, required this.widget});
  // Function function;
  // Widget widget;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String statusText = 'Loading';
  // static ContractLinker linker = ContractLinker();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, init);
  }

  void init() async {
    setup().then((value) {
      print("DONE INIT");
    });
  }

  void run(m) {
    // If wallet doesnt exists, show getstarted
    return;
  }

  Future<void> setup() async {
    // Load Wallet
    try {
      await Future.delayed(Duration(seconds: 1));
      await Preferences.init();
      setStatus("Loading Account");
      Global.linker = ContractLinker();
      Global.linker.init();
      Global.linker.loadContracts();
      await Global.linker.contract_loaded;
      await Global.linker.createAccount();
      setStatus("Getting Started");
    } catch (err) {
      print("Error got");
      print(err);
    }
    await Future.delayed(Duration(milliseconds: 50));
    Navigator.pushReplacementNamed(context, 'getstarted');
  }

  void setStatus(String text) {
    setState(() {
      statusText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // decoration: BoxDecoration(color: Colors.white),
        body: Stack(
      children: [
        Positioned(
            top: 40,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Center(
                    child: Text(
                      statusText,
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ),
                ],
              ),
            )),
        Positioned(
          top: MediaQuery.of(context).size.height / 3.5,
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'src/images/icon.png',
                      width: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text("VoteChain",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Poppins',
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w700,
                            color: Colors.green))
                  ]),
            ),
          ),
        ),
        Positioned(
            top: MediaQuery.of(context).size.height / 1.6,
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xFF54CFF6))
                    ]))),
        Positioned(
            bottom: 50,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: const Center(
                child: Text(
                  "“Your Trusted Blockchain E-Voting Platform”",
                  style: TextStyle(
                    color: Color.fromARGB(217, 77, 77, 77),
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.14,
                  ),
                ),
              ),
            ))
      ],
    ));
  }
}
