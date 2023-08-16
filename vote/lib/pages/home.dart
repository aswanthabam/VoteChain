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
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
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
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      IdentityCard(
                        isVerified: isVerified,
                        address: address,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

// stful
class IdentityCard extends StatelessWidget {
  IdentityCard({super.key, required this.isVerified, required this.address});
  bool isVerified;
  String address;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 200,
        padding: const EdgeInsets.all(20),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(1.00, -0.06),
            end: Alignment(-1, 0.06),
            colors: [
              Color.fromARGB(255, 20, 82, 95),
              Color.fromARGB(255, 35, 79, 68)
            ],
          ),
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 5, color: Colors.blue.shade400),
              borderRadius: BorderRadius.circular(20)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Text("Indian Digital Identity Card",
                    style: TextStyle(color: Colors.white, fontSize: 12))),
            const SizedBox(height: 10),
            Container(
                decoration: BoxDecoration(color: Colors.white),
                height: 1,
                width: double.infinity),
            const SizedBox(height: 10),
            Row(children: [
              SizedBox(width: 15),
              Text("NAME: ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12)),
              Text(Global.userName!,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12)),
              const Spacer(),
              Text("DOB: ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 12)),
              Text("13/06/2004",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12)),
            ]),
            const Spacer(),
            Text(
              "${Global.userId}",
              style: TextStyle(
                  letterSpacing: 5,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.yellow.shade600),
            ),
            const SizedBox(height: 10),
            Center(
                child: Text(
                    isVerified ? "Digitaly Verified" : "Pending Verification",
                    style: TextStyle(color: Colors.grey, fontSize: 12))),
            const SizedBox(height: 5),
            SelectableText(
              "$address",
              maxLines: 1,
              style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 9,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ));
  }
}
