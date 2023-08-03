import 'package:flutter/material.dart';
import 'package:vote/classes/global.dart';
import 'package:vote/components/appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String address = "";
  String balance = "";
  bool isVerified = false;
  @override
  void initState() {
    super.initState();
    Global.linker.getAddress().then((value) {
      setState(() {
        address = value.toString();
      });
    });
    Global.linker.getBalance().then((value) {
      setState(() {
        balance = value.toString();
      });
      Global.linker.isVerified().then((value) {
        setState(() {
          isVerified = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        height: AppBar().preferredSize.height,
      ),
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Stack(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isVerified
                    ? Text("Account Verified")
                    : Text("Account not verified, waiting for verification"),
                SelectableText(
                  "Address : " + address,
                  maxLines: 1,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                Text("Balance : " + balance + " ETH")
              ],
            )
          ]),
        ),
      ),
    );
  }
}
