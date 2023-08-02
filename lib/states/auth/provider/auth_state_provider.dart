import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/auth/model/auth_state.dart';
import 'package:instagram_clone/states/auth/notifier/auth_state_notifier.dart';

final authStateProvider = StateNotifierProvider<AuthStateNofitifer, AuthState>(
    (_) => AuthStateNofitifer());
