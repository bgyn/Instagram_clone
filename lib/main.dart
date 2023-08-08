import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/auth/provider/is_loggedin_provider.dart';
import 'package:instagram_clone/states/provider/is_loading_provider.dart';
import 'package:instagram_clone/views/component/loading/loading_screen.dart';
import 'package:instagram_clone/views/login/login_view.dart';
import 'package:instagram_clone/views/main/main_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagarm Clone',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Consumer(builder: (context, ref, child) {
        //take care of display loading screen
        ref.listen<bool>(isLoadingProvider, (_, isLoading) {
          if (isLoading) {
            LoadingScreen.instance().show(
              context: context,
            );
          } else {
            LoadingScreen.instance().hide();
          }
        });

        final isLoggedIn = ref.watch(isLoggedInProvider);
        if (isLoggedIn) {
          return const MainView();
        } else {
          return const LoginView();
        }
      }),
    );
  }
}
