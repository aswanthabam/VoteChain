import 'package:flutter/material.dart';
import 'package:vote/screens/pages/register/register.dart';
import 'package:vote/screens/widgets/content_views/underlined_text/underlined_text.dart';
import 'package:vote/services/blockchain/wallet.dart';
import '../../../widgets/paginated_views/paginated_views.dart' as paging;

class PhraseConfirmPage extends FormPage<bool> {
  @override
  // ignore: overridden_fields
  bool? validatedData;

  @override
  FormPageStatus validate() {
    return FormPageStatus(true,
        "Make sure that you write down or remembered the 4 phrases, If you forget them it will be much harder to recover your account");
  }

  @override
  Widget build(paging.PaginationContext state) {
    return PhraseConfirmWidget(pageState: this);
  }
}

class PhraseConfirmWidget extends StatefulWidget {
  const PhraseConfirmWidget({super.key, required this.pageState});

  final paging.PageState pageState;
  @override
  State<PhraseConfirmWidget> createState() => _PhraseConfirmWidgetState();
}

class _PhraseConfirmWidgetState extends State<PhraseConfirmWidget> {
  @override
  void initState() {
    super.initState();
    widget.pageState.bindWidgetState(setState);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          const UnderlinedText(
              heading: "Note Down Your Phrases!",
              fontSize: 20,
              color: Colors.black,
              underlineColor: Colors.green,
              underlineWidth: 200,
              underlineHeight: 5),
          const Text(
              "Please remember or write down this 4 phrases, you may require this phrases when you try to login to votechain. Learn more about votechain here."),
          const Spacer(),
          Column(
            children: VoteChainWallet.mnemonic!
                .sublist(0, 4)
                .map((e) => Container(
                      decoration: BoxDecoration(
                          color: Colors.green.withAlpha(100),
                          borderRadius: BorderRadius.circular(15)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      margin: const EdgeInsets.only(bottom: 10),
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text(
                        e,
                        style: const TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 5, 78, 7),
                            fontWeight: FontWeight.bold),
                      )),
                    ))
                .toList(),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
