import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/auth/provider/auth_state_provider.dart';
import 'package:instagram_clone/views/constants/app_colors.dart';
import 'package:instagram_clone/views/constants/string.dart';
import 'package:instagram_clone/views/login/divider_with_margin.dart';
import 'package:instagram_clone/views/login/google_button.dart';
import 'package:instagram_clone/views/login/login_view_signup.dart';

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(Strings.appName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                Strings.welcomeToAppName,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const Divider(), 
              Text(
                Strings.logIntoYourAccount,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(height: 1.5),
              ),
              const SizedBox(
                height: 44.0,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColor.loginButtonColor,
                  foregroundColor: AppColor.loginButtonTextColor, 
                ),
                onPressed:
                    ref.watch(authStateProvider.notifier).loginWithGoogle,
                child: const GoogleButton(),
              ),
              const DividerWithMargin(),
              const LoginViewSignUpLinks(),
            ],
          ),
        ),
      ),
    );
  }
}
