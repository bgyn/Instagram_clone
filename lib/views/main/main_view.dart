import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/auth/provider/auth_state_provider.dart';
import 'package:instagram_clone/views/component/dialog/alert_dialog_model.dart';
import 'package:instagram_clone/views/component/dialog/logout_dialog.dart';
import 'package:instagram_clone/views/constants/string.dart';
import 'package:instagram_clone/views/tabs/user_post/user_post_view.dart';

class MainView extends ConsumerStatefulWidget {
  const MainView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends ConsumerState<MainView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
          ),
          actions: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.film,
              ),
              onPressed: () async {},
            ),
            IconButton(
              icon: const Icon(Icons.add_photo_alternate_outlined),
              onPressed: () async {},
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                final shouldLogOut = await const LogOutDialog()
                    .present(context)
                    .then((value) => value ?? false);
                if (shouldLogOut) {
                  await ref.read(authStateProvider.notifier).logOUt();
                }
              },
            ),
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.person),
              ),
              Tab(
                icon: Icon(Icons.search),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UserPostView(),
            UserPostView(),
            UserPostView(),
          ],
        ),
      ),
    );
  }
}


