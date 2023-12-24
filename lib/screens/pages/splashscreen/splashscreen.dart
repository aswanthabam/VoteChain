// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:vote/screens/pages/splashscreen/password_page.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/services/blockchain/blockchain_client.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/utils/initializer/initializer.dart';
import 'package:web3dart/web3dart.dart';
import '../../../services/global.dart';

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
      setStatus("Loading Client");
      ClientStatus status = await initializeClient();
      if (status == ClientStatus.failed) {
        setStatus(status.message);
        showDialog(
            context: context,
            builder: (context) {
              return TextPopup(message: status.message, bottomButtons: [
                TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await setup();
                    },
                    child: const Text("Retry!"))
              ]);
            });
        return;
      }
      setStatus("Loading Contracts");
      ContractInitializationStatus sts = await initializeContracts();
      if (sts == ContractInitializationStatus.failed) {
        setStatus(sts.message);
        showDialog(
            context: context,
            builder: (context) {
              return TextPopup(message: sts.message, bottomButtons: [
                TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      await setup();
                    },
                    child: const Text("Retry!"))
              ]);
            });
        return;
      }
      setStatus("Loading Account");
      if (await VoteChainWallet.hasSavedWallet()) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => PasswordPage(
                  onPasswordSubmit: (String pin) async {
                    bool sts = await VoteChainWallet.loadWallet(pin);
                    if (sts) {
                      Navigator.pushReplacementNamed(context, "home");
                      return true;
                    }
                    showDialog(
                        context: context,
                        builder: (context) => TextPopup(
                              message:
                                  "The pin you entered is Wrong,Please recheck the pin",
                              bottomButtons: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Try Again!"))
                              ],
                            ));
                    return false;
                  },
                )));
        return;
      } else {
        await VoteChainWallet.createAccount();
        goto = "getstarted";
      }

      await Future.delayed(const Duration(seconds: 1));
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
