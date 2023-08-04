import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/views/component/loading/loading_screen.dart';

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
            builder: (_, ref, child) {
              return IconButton(
                onPressed: () async {
                  LoadingScreen.instance()
                      .show(context: context, text: 'Hello World');
                  // ref.read(authStateProvider.notifier).logOUt();
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
