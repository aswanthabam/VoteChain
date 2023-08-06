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
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Welcome",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "${Global.userName!}, ",
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          width: double.infinity,
                          height: 200,
                          padding: const EdgeInsets.all(20),
                          decoration: ShapeDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment(1.00, -0.06),
                              end: Alignment(-1, 0.06),
                              colors: [Color(0xFF31C6E7), Color(0xFF67EACA)],
                            ),
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 5, color: Colors.blue.shade400),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${Global.userId}",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              )
                            ],
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          const Text(
                            "Account Status",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          isVerified
                              ? const Text("Account Verified")
                              : const Text(
                                  "Account not verified, waiting for verification"),
                          SelectableText(
                            "Address : $address",
                            maxLines: 1,
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis),
                          ),
                          Text("Balance : $balance ETH")
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
