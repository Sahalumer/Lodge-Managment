import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project/widgets/colors.dart';
import 'package:project/privacy_terms/terms_and_privacy/privacy_terms_diologue.dart';

class TermsOfUse extends StatelessWidget {
  const TermsOfUse({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: 'By creating An Acoount, Yor are agreeing to our\n',
            style: const TextStyle(color: white),
            children: [
              TextSpan(
                text: 'Terms & Condition ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PolicyDiologue(
                              mdFileName: 'terms_condition.md');
                        });
                  },
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const TextSpan(text: 'and '),
              TextSpan(
                text: 'Privacy Policy! ',
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PolicyDiologue(
                              mdFileName: 'privacy_policy.md');
                        });
                  },
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ]),
      ),
    );
  }
}
