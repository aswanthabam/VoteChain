import 'package:flutter/material.dart';
import 'package:vote/components/content_views/dropdown.dart';
import '../../utils/paginated_views.dart' as paging;

class RegisterInfoPage extends paging.Page {
  @override
  Widget build(paging.PaginationContext state) {
    return RegisterInfoWidget(pageState: this);
  }
}

class RegisterInfoWidget extends StatefulWidget {
  RegisterInfoWidget({super.key, required this.pageState});

  paging.PageState pageState;
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
            Text("Welcome to"),
            Text("VoteChain"),
            Text(
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
            SizedBox(
              height: 10,
            ),
            ContentDropdown(
              heading: "Election Details",
              contents: [],
              height: 100,
            ),
            ContentDropdown(
              heading: "Document Uploadation",
              contents: [],
              height: 100,
            ),
            ContentDropdown(
              heading: "Face Registaration",
              contents: [],
              height: 100,
            ),
          ]))
    ]));
  }
}