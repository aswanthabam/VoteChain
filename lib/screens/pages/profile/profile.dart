import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/buttons/fullsize_action_button/full_size_action_button.dart';
import 'package:vote/screens/widgets/content_views/card/card.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/services/blockchain/wallet.dart';

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
            Padding(
              padding: const EdgeInsets.all(5),
              child: FullSizeActionButton(
                icon: const Icon(Icons.logout),
                icon2: const Icon(Icons.chevron_right_outlined),
                text: "Logout",
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => TextPopup(
                            message:
                                "Are You sure you want to logout? You want to login with your credentials again to relogin.",
                            bottomButtons: [
                              TextButton(
                                  onPressed: () async {
                                    await VoteChainWallet.logOut();
                                    Navigator.pushReplacementNamed(
                                        context, 'getstarted');
                                  },
                                  child: const Text(
                                    "Yes, Logout",
                                    style: TextStyle(color: Colors.red),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No, Exit"))
                            ],
                          ));
                },
              ),
            ),
          ]))),
    );
  }
}
