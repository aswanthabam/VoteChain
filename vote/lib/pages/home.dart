import 'package:flutter/material.dart';
import 'package:vote/classes/global.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String address = "";
  String balance = "";
  @override
  void initState() {
    super.initState();

    setState(() async {
      address = (await Global.linker.getAddress()).toString();
      balance = (await Global.linker.getBalance()).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Address : " + address),
          Text("Balance : " + balance + " ETH")
        ],
      ),
    );
  }
}
