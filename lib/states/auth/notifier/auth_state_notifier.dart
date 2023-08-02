import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/auth/backend/authenticator.dart';
import 'package:instagram_clone/states/auth/model/auth_result.dart';
import 'package:instagram_clone/states/auth/model/auth_state.dart';
import 'package:instagram_clone/states/post/typedefs/user_id.dart';
import 'package:instagram_clone/states/user_info/backend/user_info_storage.dart';

class AuthStateNofitifer extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();
  AuthStateNofitifer() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: true,
        userId: _authenticator.userId,
      );
    }
  }
  Future<void> logOUt() async {
    state = state.copyWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWithIsLoading(true);
    final result =await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: userId,
    );
  }

  Future<void> saveUserInfo({required UserId userId}) =>
      _userInfoStorage.saveUserInfo(
        userId: userId, 
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}
