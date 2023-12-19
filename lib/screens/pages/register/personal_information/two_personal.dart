import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/grouped_input_field.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/status_bar/status_bar.dart';
import 'package:vote/utils/types/user_types.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class RegisterPersonalInfoTwoPage extends FormPage<PersonalInfo> {
  @override
  PersonalInfo? validatedData;

  @override
  FormPageStatus validate() {
    return FormPageStatus(true, "All fields are valid");
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

  InputFieldHandler residentialHouseName =
      InputFieldHandler(label: "House Name *");
  InputFieldHandler residentialHouseNo = InputFieldHandler(label: "House No *");
  InputFieldHandler residentialStreet = InputFieldHandler(label: "Street *");
  InputFieldHandler residentialPincode = InputFieldHandler(label: "Pincode *");

  late GroupedInputFieldHandler residentialAddress;
  InputFieldHandler residentialState =
      InputFieldHandler(label: "Select State *");
  InputFieldHandler residentialDistrict =
      InputFieldHandler(label: "Select District *");
  InputFieldHandler residentialLocality =
      InputFieldHandler(label: "Select Locality *");
  InputFieldHandler residentialWard = InputFieldHandler(label: "Select Ward *");

  @override
  void initState() {
    super.initState();
    address = GroupedInputFieldHandler(
        inputFields: [state, district, locality, ward], columnCount: 2);
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
                  const Text("Residential Details",
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
                            "Enter your current Residential Address & Permanent Address"),
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
                        address.widget,
                        const SizedBox(height: 20),
                        houseName.widget,
                        const SizedBox(height: 20),
                        houseNo.widget,
                        const SizedBox(height: 20),
                        locality.widget,
                        const SizedBox(height: 20),
                        pincode.widget,
                        const SizedBox(height: 20),
                        const UnderlinedText(
                          heading: "Residential Address",
                          fontSize: 13,
                          color: Color.fromARGB(255, 38, 38, 38),
                          underlineColor: Color.fromARGB(255, 128, 129, 128),
                          underlineWidth: 50,
                          underlineHeight: 3,
                        ),
                        const Text("Enter your Residential Address. "),
                        address.widget,
                        const SizedBox(height: 20),
                        houseName.widget,
                        const SizedBox(height: 20),
                        houseNo.widget,
                        const SizedBox(height: 20),
                        locality.widget,
                        const SizedBox(height: 20),
                        pincode.widget,
                        const SizedBox(height: 20),
                      ],
                    ),
                  )
                ])));
  }
}
