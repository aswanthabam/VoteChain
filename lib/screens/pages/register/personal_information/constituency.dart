import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/provider/voter_provider.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/services/api/location/location.dart';
import 'package:vote/utils/types/api_types.dart' as types;
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class ConstituencySelectorPage extends FormPage<String> {
  @override
  // ignore: overridden_fields
  String? validatedData;

  @override
  FormPageStatus validate() {
    InputFieldHandler? constituency =
        getState<InputFieldHandler>("constituency");
    if (constituency == null || constituency.text.isEmpty) {
      return FormPageStatus(false,
          "The constituency you entered is not valid,please enter a valid constituency");
    }
    validatedData = constituency.text;
    return FormPageStatus(true,
        "The Personal info you entered seams to be correct, please verify it before continuing");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return ConstituencySelectorWidget(pageState: this);
  }
}

class ConstituencySelectorWidget extends StatefulWidget {
  const ConstituencySelectorWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<ConstituencySelectorWidget> createState() =>
      _ConstituencySelectorWidgetState();
}

class _ConstituencySelectorWidgetState
    extends State<ConstituencySelectorWidget> {
  late InputFieldHandler constituency;
  List<types.State> states = [
    types.State(id: "1", name: "Loading ...", code: "KL", noOfDistricts: 0),
  ];
  List<types.District> districts = [
    types.District(
        id: "1",
        name: "Loading ...",
        code: "KL",
        noOfConstituencies: 0,
        image: '',
        description: '',
        link: '',
        state: "1")
  ];
  List<types.Constituency> constituencies = [
    types.Constituency(
        id: "1",
        name: "Loading ...",
        code: "KL",
        image: '',
        description: '',
        link: '',
        district: "1")
  ];

  types.State? selectedState;
  types.District? selectedDistrict;
  types.Constituency? selectedConstituency;

  @override
  void initState() {
    super.initState();
    widget.pageState.bindWidgetState(setState);
    constituency = InputFieldHandler(
      label: "Constituency *",
      initialValue:
          Provider.of<VoterModal>(context, listen: false).constituency,
      onChanged: (String val) {
        Provider.of<VoterModal>(context, listen: false).constituency = val;
        widget.pageState
            .setState<InputFieldHandler>("constituency", constituency);
      },
      secureText: true,
    );
    LocationCall().getStates().then((value) {
      if (value.isNotEmpty) {
        states = value;
        setState(() {});
      }
    });
    widget.pageState.setState("constituency", constituency);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UnderlinedText(
                  heading: "Select your constituency",
                  fontSize: 30,
                  color: Color.fromARGB(255, 3, 43, 5),
                  underlineColor: Colors.green,
                  underlineWidth: 200,
                  underlineHeight: 5),
              const Text(
                  "Please select your constituency, choose your state and district from the dropdowns below and choose your constituency. you will be able to vote in this constituency only"),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.info_outline, size: 13),
                  SizedBox(width: 10),
                  Text(
                    "Select state where you have vote *",
                    style: TextStyle(
                        fontSize: 13, color: Color.fromARGB(255, 87, 99, 87)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: CustomDropdown<types.State>.search(
                      hintText: "Select state",
                      items: states,
                      onChanged: (types.State state) async {
                        selectedState = state;
                        districts = await LocationCall()
                            .getDistricts(stateId: state.id);
                        setState(() {});
                      })),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.info_outline, size: 13),
                  SizedBox(width: 10),
                  Text(
                    "Select district where you have vote *",
                    style: TextStyle(
                        fontSize: 13, color: Color.fromARGB(255, 87, 99, 87)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: CustomDropdown<types.District>.search(
                      hintText: "Select District",
                      items: districts,
                      onChanged: (types.District state) async {
                        selectedDistrict = state;
                        constituencies = await LocationCall()
                            .getConstituencies(districtId: state.id);
                        setState(() {});
                      })),
              const SizedBox(
                height: 10,
              ),
              const Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.info_outline, size: 13),
                  SizedBox(width: 10),
                  Text(
                    "Select constituency where you have vote *",
                    style: TextStyle(
                        fontSize: 13, color: Color.fromARGB(255, 87, 99, 87)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width - 40,
                  child: CustomDropdown<types.Constituency>.search(
                      hintText: "Select Constituency",
                      items: constituencies,
                      onChanged: (types.Constituency state) {
                        selectedConstituency = state;
                        constituency.text = state.id;
                        widget.pageState.setState<InputFieldHandler>(
                            "constituency", constituency);
                        setState(() {});
                      })),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
