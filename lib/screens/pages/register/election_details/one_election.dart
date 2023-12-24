import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/status_bar/status_bar.dart';
import 'package:vote/utils/types/user_types.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class RegisterElectionDetailsOnePage extends FormPage<PersonalInfo> {
  @override
  PersonalInfo? validatedData;

  @override
  FormPageStatus validate() {
    return FormPageStatus(true, "All fields are valid");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return RegisterElectionDetailsOneWidget(pageState: this);
  }
}

class RegisterElectionDetailsOneWidget extends StatefulWidget {
  const RegisterElectionDetailsOneWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<RegisterElectionDetailsOneWidget> createState() =>
      _RegisterElectionDetailsOneWidgetState();
}

class _RegisterElectionDetailsOneWidgetState
    extends State<RegisterElectionDetailsOneWidget> {
  InputFieldHandler assemblyState = InputFieldHandler(label: "State*");
  InputFieldHandler assemblyDistrict = InputFieldHandler(label: "District *");
  InputFieldHandler assemblyLocality = InputFieldHandler(label: "Locality *");
  InputFieldHandler assemblyConstituency =
      InputFieldHandler(label: "Assembly Constituency *");
  // InputFieldHandler middleName = InputFieldHandler(label: "Middle Name");
  // InputFieldHandler lastName = InputFieldHandler(label: "Last Name");
  // InputFieldHandler phoneNumber = InputFieldHandler(label: "Phone Number");
  // InputFieldHandler email = InputFieldHandler(label: "Email");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Election Details",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child:
                        const StatusBar(fractions: 4, current: 4, padding: 0),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const UnderlinedText(
                          heading: "Your Parlimentary Constituency",
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color(0xff1CA78E),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text(
                            "Enter your details regarding your parlementary constituency. Know more about parlimentary constituencies"),
                        const SizedBox(height: 20),
                        assemblyState.widget,
                        const SizedBox(height: 20),
                        assemblyDistrict.widget,
                        const SizedBox(height: 20),
                        assemblyConstituency.widget,
                        const SizedBox(height: 20),
                        const UnderlinedText(
                          heading: "Your Assembly Constituency",
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color(0xff1CA78E),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text(
                            "Enter your details regarding your assembly constituency. Know more about assembly constituencies"),
                        const SizedBox(height: 20),
                        assemblyState.widget,
                        const SizedBox(height: 20),
                        assemblyDistrict.widget,
                        const SizedBox(height: 20),
                        assemblyConstituency.widget
                      ],
                    ),
                  )
                ])));
  }
}
