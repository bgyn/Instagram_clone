import 'package:flutter/material.dart';
import 'package:instagram_clone/states/auth/backend/authenticator.dart';
import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Home Page"),
      ),
      body: TextButton(
          onPressed: () async {
            final result = await Authenticator().loginWithGoogle();
            result.log();
          },
          child: const Text("Google")),
    );
  }
}
