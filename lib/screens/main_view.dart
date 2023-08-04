import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/auth/provider/auth_state_provider.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Main View"),
        actions: [
          Consumer(
            builder: (context, ref, child) {
              return IconButton(
                onPressed: () async {
                  ref.read(authStateProvider.notifier).logOUt();
                },
                icon: const Icon(Icons.logout_outlined),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text("Logged In"),
      ),
    );
  }
}
