import 'package:flutter/material.dart';
import 'package:instagram_clone/views/component/rich_text/base_text.dart';
import 'package:instagram_clone/views/component/rich_text/rich_text_widget.dart';
import 'package:instagram_clone/views/constants/string.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginViewSignUpLinks extends StatelessWidget {
  const LoginViewSignUpLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return RichTextWidget(
      styleForAll: Theme.of(context).textTheme.titleMedium?.copyWith(
            height: 1.5,
          ),
      texts: [
        BaseText.plain(text: Strings.dontHaveAnAccount),
        BaseText.plain(text: Strings.signUpOn),
        BaseText.link(
          text: Strings.google,
          onTapped: () {
            launchUrl(
              Uri.parse(Strings.googleSignupUrl),
            );
          },
        )
      ],
    );
  }
}
