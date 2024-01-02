import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/qrcode/qr_scanner.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/buttons/icon_button/icon_button.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/status_bar/status_bar.dart';
import 'package:vote/services/global.dart';
import 'package:vote/utils/types/user_types.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class RegisterPersonalInfoThreePage extends FormPage<PersonalInfo> {
  @override
  // ignore: overridden_fields
  PersonalInfo? validatedData;

  @override
  FormPageStatus validate() {
    return FormPageStatus(true, "All fields are valid");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return RegisterPersonalInfoThreeWidget(pageState: this);
  }
}

class RegisterPersonalInfoThreeWidget extends StatefulWidget {
  const RegisterPersonalInfoThreeWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<RegisterPersonalInfoThreeWidget> createState() =>
      _RegisterPersonalInfoThreeWidgetState();
}

class _RegisterPersonalInfoThreeWidgetState
    extends State<RegisterPersonalInfoThreeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Parental Details",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child:
                        const StatusBar(fractions: 4, current: 3, padding: 0),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            "Here you want to enter details of your parents (spouse if,)."),
                        const SizedBox(
                          height: 20,
                        ),
                        const UnderlinedText(
                          heading: "Parental Details",
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color(0xff1CA78E),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const UnderlinedText(
                          heading: "Father Details",
                          fontSize: 15,
                          color: Color.fromARGB(255, 117, 115, 115),
                          underlineColor: Color(0xff1CA78E),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text(
                            "Enter details of your father by connecting your fathers VoteChain account or enter and upload documents manually."),
                        const SizedBox(height: 20),
                        IconButtonWidget(
                            icon: Icons.qr_code,
                            text: "Link Father Account with VoteChain QR",
                            onClick: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QRScanner(
                                              heading:
                                                  "Link Your Father Account",
                                              helpText:
                                                  "Scan the QR code of your father's VoteChain account to link it with your account.",
                                              exitOnResult: true,
                                              onResult: (String result) async {
                                                Global.logger.i(
                                                    "Successfully scanned qr code and got result : $result");
                                              })))
                                }),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                            child: Text(
                          "Or, continue enter manualy",
                          style: TextStyle(fontSize: 13),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        const UnderlinedText(
                          heading: "Mother Details",
                          fontSize: 15,
                          color: Color.fromARGB(255, 117, 115, 115),
                          underlineColor: Color(0xff1CA78E),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text(
                            "Enter details of your mother by connecting your mothers VoteChain account or enter and upload documents manually."),
                        const SizedBox(height: 20),
                        IconButtonWidget(
                            icon: Icons.qr_code,
                            text: "Link Mother Account with VoteChain QR",
                            onClick: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QRScanner(
                                              heading:
                                                  "Link Your Mother Account",
                                              helpText:
                                                  "Scan the QR code of your mother's VoteChain account to link it with your account.",
                                              exitOnResult: true,
                                              onResult: (String result) async {
                                                Global.logger.i(
                                                    "Successfully scanned qr code and got result : $result");
                                              })))
                                }),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                            child: Text(
                          "Or, continue enter manualy",
                          style: TextStyle(fontSize: 13),
                        )),
                        const SizedBox(
                          height: 20,
                        ),
                        const UnderlinedText(
                          heading: "Spouse Details",
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color(0xff1CA78E),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text(
                            "Enter details of your spouse by connecting your spouse VoteChain account or enter and upload documents manually."),
                        const SizedBox(height: 20),
                        IconButtonWidget(
                            icon: Icons.qr_code,
                            text: "Link Spouse Account with VoteChain QR",
                            onClick: () => {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => QRScanner(
                                              heading:
                                                  "Link Your Spouse Account",
                                              helpText:
                                                  "Scan the QR code of your spouse VoteChain account to link it with your account.",
                                              exitOnResult: true,
                                              onResult: (String result) async {
                                                Global.logger.i(
                                                    "Successfully scanned qr code and got result : $result");
                                              })))
                                }),
                        const SizedBox(
                          height: 10,
                        ),
                        const Center(
                            child: Text(
                          "Or, continue enter manualy",
                          style: TextStyle(fontSize: 13),
                        )),
                      ],
                    ),
                  )
                ])));
  }
}
