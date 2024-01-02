import 'package:flutter/material.dart';
import 'package:vote/screens/layers/default_layer.dart';
import 'package:vote/screens/widgets/appbars/backbar.dart';
import 'package:vote/screens/widgets/buttons/fullsize_action_button/full_size_action_button.dart';
import 'package:vote/screens/widgets/content_views/card/card.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/services/blockchain/voter_helper.dart';
import 'package:vote/services/blockchain/wallet.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return DefaultLayer(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Text(
                        "${VoterHelper.voterInfo!.personalInfo.firstName}${' ${VoterHelper.voterInfo!.personalInfo.middleName}'} ${VoterHelper.voterInfo!.personalInfo.lastName}",
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700))),
                const SizedBox(
                  height: 10,
                ),
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
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacementNamed(
                                            context, 'splashscreen');
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
