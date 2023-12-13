import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/content_views/card/card.dart';
import 'package:vote/screens/widgets/dialog/dialog.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import '../../../services/global.dart';

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
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(children: [
              CardWidget(),
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
                      child: TextButton(
                        child: Text("LogOut"),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => TextPopup(
                                  message:
                                      "Are You sure you want to logout? You want to login with your credentials again to relogin."));
                        },
                      ))
                ],
              )
            ]),
          )),
    );
  }
}
