import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/provider/voter_provider.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/grouped_input_field.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/status_bar/status_bar.dart';
import 'package:vote/utils/types/user_types.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class RegisterPageTwoData {
  AddressInfo currentAddressInfo;
  AddressInfo permenantAddressInfo;

  RegisterPageTwoData(
      {required this.currentAddressInfo, required this.permenantAddressInfo});
}

class RegisterPersonalInfoTwoPage extends FormPage<RegisterPageTwoData> {
  @override
  // ignore: overridden_fields
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
        permenantAddressInfo: AddressInfo(
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
  late InputFieldHandler houseName,
      houseNo,
      street,
      pincode,
      state,
      district,
      locality,
      ward,
      permenantHouseName,
      permenantHouseNo,
      permenantStreet,
      permenantPincode,
      permenantState,
      permenantDistrict,
      permenantLocality,
      permenantWard;
  late GroupedInputFieldHandler address;
  late GroupedInputFieldHandler permenantAddress;

  bool sameAspermenant = false;

  @override
  void initState() {
    super.initState();

    state = InputFieldHandler(
        label: "State *",
        initialValue:
            Provider.of<VoterModal>(context, listen: false).currentAddressState,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false).currentAddressState =
              val;
          widget.pageState
              .setState<InputFieldHandler>("currentAddressState", state);
        });
    district = InputFieldHandler(
        label: "District *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .currentAddressDistrict,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .currentAddressDistrict = val;
          widget.pageState
              .setState<InputFieldHandler>("currentAddressDistrict", district);
        });
    locality = InputFieldHandler(
        label: "Locality *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .currentAddressLocality,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .currentAddressLocality = val;
          widget.pageState
              .setState<InputFieldHandler>("currentAddressLocality", locality);
        });
    ward = InputFieldHandler(
        label: "Ward *",
        initialValue:
            Provider.of<VoterModal>(context, listen: false).currentAddressWard,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false).currentAddressWard =
              val;
          widget.pageState
              .setState<InputFieldHandler>("currentAddressWard", ward);
        });
    houseName = InputFieldHandler(
        label: "House Name *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .currentAddressHouseName,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .currentAddressHouseName = val;
          widget.pageState.setState<InputFieldHandler>(
              "currentAddressHouseName", houseName);
        });
    houseNo = InputFieldHandler(
        label: "House No *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .currentAddressHouseNumber,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .currentAddressHouseNumber = val;
          widget.pageState
              .setState<InputFieldHandler>("currentAddressHouseNo", houseNo);
        });
    street = InputFieldHandler(
        label: "Street *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .currentAddressStreet,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false).currentAddressStreet =
              val;
          widget.pageState
              .setState<InputFieldHandler>("currentAddressStreet", street);
        });
    pincode = InputFieldHandler(
        label: "Pincode *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .currentAddressPincode,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .currentAddressPincode = val;
          widget.pageState
              .setState<InputFieldHandler>("currentAddressPincode", pincode);
        });
    permenantState = InputFieldHandler(
        label: "State *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .permanentAddressState,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .permanentAddressState = val;
          widget.pageState.setState<InputFieldHandler>(
              "permenantAddressState", permenantState);
        });
    permenantDistrict = InputFieldHandler(
        label: "District *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .permanentAddressDistrict,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .permanentAddressDistrict = val;
          widget.pageState.setState<InputFieldHandler>(
              "permenantAddressDistrict", permenantDistrict);
        });
    permenantLocality = InputFieldHandler(
        label: "Locality *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .permanentAddressLocality,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .permanentAddressLocality = val;
          widget.pageState.setState<InputFieldHandler>(
              "permenantAddressLocality", permenantLocality);
        });
    permenantWard = InputFieldHandler(
        label: "Ward *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .permanentAddressWard,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false).permanentAddressWard =
              val;
          widget.pageState.setState<InputFieldHandler>(
              "permenantAddressWard", permenantWard);
        });
    permenantHouseName = InputFieldHandler(
        label: "House Name *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .permanentAddressHouseName,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .permanentAddressHouseName = val;
          widget.pageState.setState<InputFieldHandler>(
              "permenantAddressHouseName", permenantHouseName);
        });
    permenantHouseNo = InputFieldHandler(
        label: "House No *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .permanentAddressHouseNumber,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .permanentAddressHouseNumber = val;
          widget.pageState.setState<InputFieldHandler>(
              "permenantAddressHouseNo", permenantHouseNo);
        });
    permenantStreet = InputFieldHandler(
        label: "Street *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .permanentAddressStreet,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .permanentAddressStreet = val;
          widget.pageState.setState<InputFieldHandler>(
              "permenantAddressStreet", permenantStreet);
        });
    permenantPincode = InputFieldHandler(
        label: "Pincode *",
        initialValue: Provider.of<VoterModal>(context, listen: false)
            .permanentAddressPincode,
        onChanged: (String val) {
          Provider.of<VoterModal>(context, listen: false)
              .permanentAddressPincode = val;
          widget.pageState.setState<InputFieldHandler>(
              "permenantAddressPincode", permenantPincode);
        });
    address = GroupedInputFieldHandler(
        inputFields: [state, district, locality, ward], columnCount: 2);
    permenantAddress = GroupedInputFieldHandler(inputFields: [
      permenantState,
      permenantDistrict,
      permenantLocality,
      permenantWard
    ], columnCount: 2);
    widget.pageState.bindWidgetState(setState);
    widget.pageState.setState("permenantAddressState", permenantState);
    widget.pageState.setState("permenantAddressDistrict", permenantDistrict);
    widget.pageState.setState("permenantAddressLocality", permenantLocality);
    widget.pageState.setState("permenantAddressWard", permenantWard);
    widget.pageState.setState("permenantAddressHouseName", permenantHouseName);
    widget.pageState.setState("permenantAddressHouseNo", permenantHouseNo);
    widget.pageState.setState("permenantAddressStreet", permenantStreet);
    widget.pageState.setState("permenantAddressPincode", permenantPincode);

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
                  const Text("Address Details",
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
                            "Enter your current permenant Address & Permanent Address"),
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
                        permenantAddress.widget,
                        const SizedBox(height: 20),
                        permenantHouseName.widget,
                        const SizedBox(height: 20),
                        permenantHouseNo.widget,
                        const SizedBox(height: 20),
                        permenantStreet.widget,
                        const SizedBox(height: 20),
                        permenantPincode.widget,
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                                value: sameAspermenant,
                                onChanged: (bool? val) {
                                  if (val == null || !val) {
                                    setState(() {
                                      sameAspermenant = false;
                                    });
                                    return;
                                  }
                                  setState(() {
                                    sameAspermenant = true;
                                    state.text = permenantState.text;
                                    district.text = permenantDistrict.text;
                                    locality.text = permenantLocality.text;
                                    ward.text = permenantWard.text;
                                    houseName.text = permenantHouseName.text;
                                    houseNo.text = permenantHouseNo.text;
                                    street.text = permenantStreet.text;
                                    pincode.text = permenantPincode.text;
                                  });
                                }),
                            const Text("Same as permenant address")
                          ],
                        ),
                        const SizedBox(height: 20),
                        sameAspermenant
                            ? const SizedBox(
                                height: 20,
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const UnderlinedText(
                                    heading: "Residential Address",
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 38, 38, 38),
                                    underlineColor:
                                        Color.fromARGB(255, 128, 129, 128),
                                    underlineWidth: 50,
                                    underlineHeight: 3,
                                  ),
                                  const Text(
                                      "Enter your residential Address. "),
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
                              )
                      ],
                    ),
                  )
                ])));
  }
}
