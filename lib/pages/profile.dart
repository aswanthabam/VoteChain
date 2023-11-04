import 'package:flutter/material.dart';
import '../classes/global.dart';
import '../components/appbars/backbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackBar(onPressed: () {
        Navigator.pop(context);
      }),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(children: [
              Row(
                children: [Text("Name : ${Global.userName}")],
              ),
              Row(
                children: [
                  const Spacer(),
                  TextButton(
                      onPressed: () {
                        Global.linker.logOut();
                        Navigator.pushReplacementNamed(context, "getstarted");
                      },
                      child: Text("LogOut"))
                ],
              )
            ]),
          )),
    );
  }
}
