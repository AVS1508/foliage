// Flutter imports:
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Center(
        child: Text.rich(
          TextSpan(
            text: 'By continuing, you agree to our ',
            style: const TextStyle(
              fontSize: 14,
            ),
            children: <TextSpan>[
              TextSpan(
                text: 'Terms of Service.',
                style: const TextStyle(
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Terms of Service.');
                  },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
