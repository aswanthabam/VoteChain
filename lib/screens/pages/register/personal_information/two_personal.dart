import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/grouped_input_field.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/status_bar/status_bar.dart';
import 'package:vote/utils/types/user_types.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class RegisterPageTwoData {
  AddressInfo currentAddressInfo;
  AddressInfo permenentAddressInfo;

  RegisterPageTwoData(
      {required this.currentAddressInfo, required this.permenentAddressInfo});
}

class RegisterPersonalInfoTwoPage extends FormPage<RegisterPageTwoData> {
  @override
  RegisterPageTwoData? validatedData;

  @override
  FormPageStatus validate() {
    InputFieldHandler? state =
        getState<InputFieldHandler>("currentAddressState");
    InputFieldHandler? district =
        getState<InputFieldHandler>("currentAddressDistrict");
    InputFieldHandler? locality =
        getState<InputFieldHandler>("currentAddressLocality");
    InputFieldHandler? ward = getState<InputFieldHandler>("currentAddressWard");
    InputFieldHandler? houseName =
        getState<InputFieldHandler>("currentAddressHouseName");
    InputFieldHandler? houseNo =
        getState<InputFieldHandler>("currentAddressHouseNo");
    InputFieldHandler? street =
        getState<InputFieldHandler>("currentAddressStreet");
    InputFieldHandler? pincode =
        getState<InputFieldHandler>("currentAddressPincode");
    InputFieldHandler? residentialState =
        getState<InputFieldHandler>("permenantAddressState");
    InputFieldHandler? residentialDistrict =
        getState<InputFieldHandler>("permenantAddressDistrict");
    InputFieldHandler? residentialLocality =
        getState<InputFieldHandler>("permenantAddressLocality");
    InputFieldHandler? residentialWard =
        getState<InputFieldHandler>("permenantAddressWard");
    InputFieldHandler? residentialHouseName =
        getState<InputFieldHandler>("permenantAddressHouseName");
    InputFieldHandler? residentialHouseNo =
        getState<InputFieldHandler>("permenantAddressHouseNo");
    InputFieldHandler? residentialStreet =
        getState<InputFieldHandler>("permenantAddressStreet");
    InputFieldHandler? residentialPincode =
        getState<InputFieldHandler>("permenantAddressPincode");
    if (state == null ||
        district == null ||
        locality == null ||
        ward == null ||
        houseName == null ||
        houseNo == null ||
        street == null ||
        pincode == null ||
        residentialState == null ||
        residentialDistrict == null ||
        residentialLocality == null ||
        residentialWard == null ||
        residentialHouseName == null ||
        residentialHouseNo == null ||
        residentialStreet == null ||
        residentialPincode == null ||
        state.text.isEmpty ||
        district.text.isEmpty ||
        locality.text.isEmpty ||
        ward.text.isEmpty ||
        houseName.text.isEmpty ||
        houseNo.text.isEmpty ||
        street.text.isEmpty ||
        pincode.text.isEmpty ||
        residentialState.text.isEmpty ||
        residentialDistrict.text.isEmpty ||
        residentialLocality.text.isEmpty ||
        residentialWard.text.isEmpty ||
        residentialHouseName.text.isEmpty ||
        residentialHouseNo.text.isEmpty ||
        residentialStreet.text.isEmpty ||
        residentialPincode.text.isEmpty) {
      return FormPageStatus(false,
          "All fields marked * are required, Please fill all the fields");
    }

    if (pincode.text.length != 6 ||
        residentialPincode.text.length != 6 ||
        pincode.text.contains(RegExp(r'[A-Za-z]')) ||
        residentialPincode.text.contains(RegExp(r'[A-Za-z]'))) {
      return FormPageStatus(false,
          "Invalid pincode, Pincode should be 6 digits long, and should not contain any alphabets");
    }
    validatedData = RegisterPageTwoData(
        currentAddressInfo: AddressInfo(
            state: state.text,
            district: district.text,
            locality: locality.text,
            ward: ward.text,
            houseName: houseName.text,
            houseNumber: houseNo.text,
            street: street.text,
            pincode: pincode.text),
        permenentAddressInfo: AddressInfo(
            state: residentialState.text,
            district: residentialDistrict.text,
            locality: residentialLocality.text,
            ward: residentialWard.text,
            houseName: residentialHouseName.text,
            houseNumber: residentialHouseNo.text,
            street: residentialStreet.text,
            pincode: residentialPincode.text));
    return FormPageStatus(true,
        "All fields are valid, please double check that the details are correct!");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return RegisterPersonalInfoTwoWidget(pageState: this);
  }
}

class RegisterPersonalInfoTwoWidget extends StatefulWidget {
  const RegisterPersonalInfoTwoWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<RegisterPersonalInfoTwoWidget> createState() =>
      _RegisterPersonalInfoTwoWidgetState();
}

class _RegisterPersonalInfoTwoWidgetState
    extends State<RegisterPersonalInfoTwoWidget> {
  InputFieldHandler houseName = InputFieldHandler(label: "House Name *");
  InputFieldHandler houseNo = InputFieldHandler(label: "House No *");
  InputFieldHandler street = InputFieldHandler(label: "Street *");
  InputFieldHandler pincode = InputFieldHandler(label: "Pincode *");

  late GroupedInputFieldHandler address;
  InputFieldHandler state = InputFieldHandler(label: "Select State *");
  InputFieldHandler district = InputFieldHandler(label: "Select District *");
  InputFieldHandler locality = InputFieldHandler(label: "Select Locality *");
  InputFieldHandler ward = InputFieldHandler(label: "Select Ward *");

  InputFieldHandler permenentHouseName =
      InputFieldHandler(label: "House Name *");
  InputFieldHandler permenentHouseNo = InputFieldHandler(label: "House No *");
  InputFieldHandler permenentStreet = InputFieldHandler(label: "Street *");
  InputFieldHandler permenentPincode = InputFieldHandler(label: "Pincode *");

  late GroupedInputFieldHandler permenentAddress;
  InputFieldHandler permenentState = InputFieldHandler(label: "Select State *");
  InputFieldHandler permenentDistrict =
      InputFieldHandler(label: "Select District *");
  InputFieldHandler permenentLocality =
      InputFieldHandler(label: "Select Locality *");
  InputFieldHandler permenentWard = InputFieldHandler(label: "Select Ward *");

  @override
  void initState() {
    super.initState();
    address = GroupedInputFieldHandler(
        inputFields: [state, district, locality, ward], columnCount: 2);
    permenentAddress = GroupedInputFieldHandler(inputFields: [
      permenentState,
      permenentDistrict,
      permenentLocality,
      permenentWard
    ], columnCount: 2);
    widget.pageState.bindWidgetState(setState);
    widget.pageState.setState("permenantAddressState", permenentState);
    widget.pageState.setState("permenantAddressDistrict", permenentDistrict);
    widget.pageState.setState("permenantAddressLocality", permenentLocality);
    widget.pageState.setState("permenantAddressWard", permenentWard);
    widget.pageState.setState("permenantAddressHouseName", permenentHouseName);
    widget.pageState.setState("permenantAddressHouseNo", permenentHouseNo);
    widget.pageState.setState("permenantAddressStreet", permenentStreet);
    widget.pageState.setState("permenantAddressPincode", permenentPincode);

    widget.pageState.setState("currentAddressState", state);
    widget.pageState.setState("currentAddressDistrict", district);
    widget.pageState.setState("currentAddressLocality", locality);
    widget.pageState.setState("currentAddressWard", ward);
    widget.pageState.setState("currentAddressHouseName", houseName);
    widget.pageState.setState("currentAddressHouseNo", houseNo);
    widget.pageState.setState("currentAddressStreet", street);
    widget.pageState.setState("currentAddressPincode", pincode);
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
                  const Text("permenent Details",
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
                        const UnderlinedText(
                          heading: "Address",
                          fontSize: 18,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color(0xff1CA78E),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text(
                            "Enter your current permenent Address & Permanent Address"),
                        const SizedBox(height: 20),
                        const UnderlinedText(
                          heading: "Permanent Address",
                          fontSize: 13,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color.fromARGB(255, 128, 129, 128),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text("Enter your Permenant Address. "),
                        permenentAddress.widget,
                        const SizedBox(height: 20),
                        permenentHouseName.widget,
                        const SizedBox(height: 20),
                        permenentHouseNo.widget,
                        const SizedBox(height: 20),
                        permenentStreet.widget,
                        const SizedBox(height: 20),
                        permenentPincode.widget,
                        const SizedBox(height: 20),
                        const UnderlinedText(
                          heading: "permenent Address",
                          fontSize: 13,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color.fromARGB(255, 128, 129, 128),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text("Enter your permenent Address. "),
                        address.widget,
                        const SizedBox(height: 20),
                        houseName.widget,
                        const SizedBox(height: 20),
                        houseNo.widget,
                        const SizedBox(height: 20),
                        street.widget,
                        const SizedBox(height: 20),
                        pincode.widget,
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                ])));
  }
}
