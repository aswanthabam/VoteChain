import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/buttons/icon_button/icon_button.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/grouped_input_field.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/status_bar/status_bar.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class RegisterPersonalInfoThreePage extends paging.Page {
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
                        const StatusBar(fractions: 4, current: 2, padding: 0),
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
                          heading: "Father Details",
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 38, 38),
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
                            onClick: () => {}),
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
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 38, 38),
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
                            onClick: () => {}),
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
