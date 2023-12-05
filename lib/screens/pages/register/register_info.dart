import 'package:flutter/material.dart';
import 'package:vote/screens/widgets/content_views/dropdown.dart';
import '../../widgets/paginated_views/paginated_views.dart' as paging;

class RegisterInfoPage extends paging.Page {
  @override
  Widget build(paging.PaginationContext state) {
    return RegisterInfoWidget(pageState: this);
  }
}

class RegisterInfoWidget extends StatefulWidget {
  const RegisterInfoWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<RegisterInfoWidget> createState() => _RegisterInfoWidgetState();
}

class _RegisterInfoWidgetState extends State<RegisterInfoWidget> {
  @override
  void initState() {
    super.initState();
    widget.pageState.bindWidgetState(setState);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(mainAxisSize: MainAxisSize.max, children: [
      Container(
          width: MediaQuery.of(context).size.width - 20,
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Welcome to",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Poppins',
                  letterSpacing: 2.5,
                  fontWeight: FontWeight.w700,
                )),
            const Text("VoteChain",
                style: TextStyle(fontSize: 30, color: Colors.green)),
            const Text(
                "For Registeing to VoteChain you want to give the following details"),
            const SizedBox(
              height: 10,
            ),
            ContentDropdown(
              heading: "Personal Details",
              contents: [
                TextContent(
                    content:
                        "NB : You can fetch these details from AAdhar or enter details manually"),
                TextContent(
                    content: "You want to enter the following details:"),
                ListContent(list: [
                  "Name",
                  "Residential Address",
                  "Date of birth",
                  "Aadhar Number",
                  "Parent Details",
                  "Marial Status",
                  "Phone Number",
                  "Email ID"
                ])
              ],
              height: 130,
            ),
            const SizedBox(
              height: 10,
            ),
            const ContentDropdown(
              heading: "Election Details",
              contents: [],
              height: 100,
            ),
            const ContentDropdown(
              heading: "Document Uploadation",
              contents: [],
              height: 100,
            ),
            const ContentDropdown(
              heading: "Face Registaration",
              contents: [],
              height: 100,
            ),
          ]))
    ]));
  }
}