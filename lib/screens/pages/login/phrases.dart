import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/screens/widgets/input_components/input_field/input_field.dart';
import '../../widgets/paginated_views/paginated_views.dart' as paging;

class PhraseQueryPage extends FormPage<String> {
  @override
  String? validatedData;

  @override
  FormPageStatus validate() {
    InputFieldHandler? phrase = getState<InputFieldHandler>("phrase");
    if (phrase == null ||
        phrase.text.isEmpty ||
        phrase.text.split(' ').length != 4) {
      return FormPageStatus(false,
          "The phrase you entered is not valid, Please Enter a valid phrase");
    }
    validatedData = phrase.text;
    return FormPageStatus(true,
        "The Personal info you entered seams to be correct, please verify it before continuing");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return PhraseQueryWidget(pageState: this);
  }
}

class PhraseQueryWidget extends StatefulWidget {
  const PhraseQueryWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<PhraseQueryWidget> createState() => _PhraseQueryWidgetState();
}

class _PhraseQueryWidgetState extends State<PhraseQueryWidget> {
  InputFieldHandler phrase = InputFieldHandler(label: 'phrase *');
  @override
  void initState() {
    super.initState();
    widget.pageState.bindWidgetState(setState);
    widget.pageState.setState("phrase", phrase);
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
                  heading: "Enter your 4 phrases",
                  fontSize: 30,
                  color: Color.fromARGB(255, 3, 43, 5),
                  underlineColor: Colors.green,
                  underlineWidth: 200,
                  underlineHeight: 5),
              const Text(
                  "Please enter your 4 phrases you created during registration, know more about phrases"),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 0,
                child: phrase.widget,
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "If you dont remember your phrases, please contact the admin to reset your account",
                style: TextStyle(color: Colors.red.shade900),
              )
            ],
          ),
        ));
  }
}
