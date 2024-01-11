// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:vote/screens/pages/login/login_aadhar.dart';
import 'package:vote/screens/pages/login/password_page.dart';
import 'package:vote/screens/pages/login/phrases.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/buttons/async_button.dart';
import 'package:vote/screens/widgets/dialog/TextPopup/TextPopup.dart';
import 'package:vote/screens/widgets/paginated_views/paginated_views.dart'
    as pagging;
import 'package:vote/services/api/user.dart';
import 'package:vote/services/blockchain/wallet.dart';
import 'package:vote/utils/encryption.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  pagging.Pagination pagination = pagging.Pagination(pages: <FormPage>[
    LoginAadharPage(),
    PasswordQueryPage(),
    PhraseQueryPage()
  ]);

  String? aadhar;
  String? phrases;
  String? password;

  void submitLogin() async {
    UserENC? encs = await UserAuthCall().loginUser(aadhar: aadhar!);
    if (encs == null) {
      showDialog(
          context: context,
          builder: (context) => TextPopup(
                  message:
                      "An error occured while logging in, please try again later",
                  bottomButtons: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Continue"))
                  ]));
      return;
    }
    String? dec1 = await decrypt(encs.enc1, password!);
    String? dec2 = await decrypt(encs.enc2, password!);
    if (dec1 == null || dec2 == null) {
      showDialog(
          context: context,
          builder: (context) => TextPopup(
                  message:
                      "The password you entered is incorrect, please try again!",
                  bottomButtons: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Continue"))
                  ]));
      return;
    }
    String allPhrases = '${phrases!.split(' ').join(' ')} $dec1 $dec2';
    bool sts = await VoteChainWallet.createAccount(mneu: allPhrases.split(' '));
    if (!sts) {
      showDialog(
          context: context,
          builder: (context) => TextPopup(
                  message:
                      "The mneumonic you entered is wrong, please try again!",
                  bottomButtons: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("Continue"))
                  ]));
      return;
    }
    Navigator.of(context).pushNamedAndRemoveUntil('home', (route) => false);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Positioned(
                  top: -100,
                  right: -100,
                  child: Image.asset(
                    'src/images/asset/ellipse_green.png',
                    width: 200,
                  )),
              Positioned(
                  left: 20,
                  top: 30,
                  child: IconButton(
                      onPressed: () {
                        if (pagination.hasPrev()) {
                          setState(() {
                            pagination.prev();
                          });
                        } else {
                          Navigator.of(context).pop();
                        }
                      },
                      icon: const Icon(Icons.arrow_back_ios))),
              Positioned(
                  right: 20,
                  top: 30,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.help_outline_outlined))),
              Positioned(
                  top: 100,
                  height: MediaQuery.of(context).size.height - 100,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(child: pagination.widget),
                      getPrimaryAsyncButton(context, () async {
                        FormPage page = pagination
                            .pages[pagination.currentIndex]! as FormPage;
                        FormPageStatus sts = page.validate();
                        // print(page.validatedData);
                        if (sts.status) {
                          switch (pagination.currentIndex) {
                            case 0:
                              break;
                            case 1:
                              aadhar = page.validatedData as String;
                              break;
                            case 2:
                              password = page.validatedData as String;
                              break;
                            case 3:
                              phrases = page.validatedData as String;
                              break;
                            default:
                          }
                          if (pagination.hasNext()) {
                            setState(() {
                              pagination.next();
                            });
                            return true;
                          } else {
                            submitLogin();
                            return true;
                          }
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => TextPopup(
                                    message: sts.message,
                                    bottomButtons: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text("Continue"))
                                    ],
                                  ));
                        }

                        return true;
                      }, "Continue", "Loading", "An Error Occured", "Continue",
                          MediaQuery.of(context).size.width - 20)
                    ],
                  )),
            ]),
          ),
        ));
  }
}
