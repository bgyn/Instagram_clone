import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'dart:developer' as devtools show log;

import 'package:instagram_clone/states/auth/provider/auth_state_provider.dart';

extension Log on Object {
  void log() => devtools.log(toString());
}

class LoginView extends ConsumerWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login View"),
      ),
      body: Center(
        child: TextButton(
          onPressed: ref.read(authStateProvider.notifier).loginWithGoogle,
          child: const Text("Sign In with Google"),
        ),
      ),
    );
  }
}
