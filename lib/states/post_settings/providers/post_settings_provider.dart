import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/post_settings/models/post_settings.dart';
import 'package:instagram_clone/states/post_settings/notifier/post_settings_notifier.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingsNotifier, Map<PostSetting, bool>>(
  (ref) => PostSettingsNotifier(),
);


