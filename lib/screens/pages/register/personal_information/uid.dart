import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vote/provider/voter_provider.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import 'package:vote/screens/widgets/input_components/keyboard.dart';
import 'package:vote/screens/widgets/input_components/valueDisplayer.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class RegisterUIDPage extends FormPage<String> {
  @override
  // ignore: overridden_fields
  String? validatedData;

  @override
  FormPageStatus validate() {
    InputFieldHandler? aadhaar = getState<InputFieldHandler>("aadhar");
    if (aadhaar == null || aadhaar.text.length != 12) {
      return FormPageStatus(false, "Please enter a valid Aadhar number");
    }
    validatedData = aadhaar.text;
    return FormPageStatus(true,
        "The Personal info you entered seams to be correct, please verify it before continuing");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return RegisterUIDWidget(pageState: this);
  }
}

class RegisterUIDWidget extends StatefulWidget {
  const RegisterUIDWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<RegisterUIDWidget> createState() => _RegisterUIDWidgetState();
}

class _RegisterUIDWidgetState extends State<RegisterUIDWidget> {
  late InputFieldHandler aadhar;
  @override
  void initState() {
    super.initState();
    aadhar = InputFieldHandler(
      label: "Aadhar number *",
      initialValue:
          Provider.of<VoterModal>(context, listen: false).aadharNumber,
      onChanged: (String val) {
        Provider.of<VoterModal>(context, listen: false).aadharNumber = val;
        widget.pageState.setState<InputFieldHandler>("aadhar", aadhar);
      },
    );
    widget.pageState.bindWidgetState(setState);
    widget.pageState.setState<InputFieldHandler>("aadhar", aadhar);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  UnderlinedText(
                      heading: "Enter your Aadhar number",
                      fontSize: 22,
                      color: const Color.fromARGB(255, 4, 81, 8),
                      underlineColor: Colors.green.shade600,
                      underlineWidth: 200,
                      underlineHeight: 5),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Please enter your 12 digit Aadhar number",
                    style: TextStyle(color: Colors.grey.shade900),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ValueDisplayer(
                    value: aadhar.text,
                    length: 12,
                    divide: const [4, 4, 4],
                    fill: '0',
                  ),
                ],
              ),
            ),
            const Spacer(),
            KeyBoard(onPressed: (String val) {
              setState(() {
                if (val == 'clr') {
                  aadhar.text = '';
                } else if (val == 'bck') {
                  if (aadhar.text.isNotEmpty) {
                    aadhar.text =
                        aadhar.text.substring(0, aadhar.text.length - 1);
                  }
                } else if (aadhar.text.length < 12) {
                  aadhar.text += val;
                }
              });
            })
          ],
        ));
  }
}
