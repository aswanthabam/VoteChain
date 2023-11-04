// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vote/classes/preferences.dart';
import 'package:vote/components/dialog/dialog.dart';
import '../classes/contract_linker.dart';
import '../classes/global.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String statusText = 'Loading';
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, init);
  }

  void init() async {
    setup().then((value) {});
  }

  /* Setup function 
    Used to initialize the app */
  Future<void> setup() async {
    String goto = "";
    try {
      await Future.delayed(const Duration(seconds: 1));
      await Preferences.init();
      setStatus("Loading Account");
      Global.linker = ContractLinker();
      Global.linker.init();
      Global.linker.loadContracts();
      await Global.linker.contract_loaded;
      setStatus("Connecting to blockchain");
      if (!await Global.linker.checkAlive()) {
        showDialog(
            context: context,
            builder: (context) => MsgDialog(
                  text: "The Server is not alive now",
                  icon: Icons.wifi_tethering_error,
                ));
        return;
      }
      if (await Global.linker.loadWallet("123456aA")) {
        goto = "home";
      } else {
        await Global.linker.createAccount();
        goto = "getstarted";
      }
      setStatus("Getting Started");
      await Future.delayed(const Duration(milliseconds: 50));
      Navigator.pushReplacementNamed(context, goto);
    } catch (err) {
      Global.logger.e("An error occured when setting up app : $err");
    }
  }

  // Set the status text
  void setStatus(String text) {
    setState(() {
      statusText = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
            top: 40,
            child: SizedBox(
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
                    const Text("VoteChain",
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
            child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(color: Color(0xFF54CFF6))
                    ]))),
        Positioned(
            bottom: 50,
            child: SizedBox(
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
