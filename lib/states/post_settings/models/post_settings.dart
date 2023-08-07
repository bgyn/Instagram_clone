import 'package:instagram_clone/states/post_settings/constants/constant.dart';

enum PostSetting {
  allowsLikes(
    title: Constants.allowLikesTitle,
    description: Constants.allowLikesDescription,
    storageKey: Constants.allowLikesStorageKey,
  ),

  allowsComments(
    title: Constants.allowCommentsTitle,
    description: Constants.allowCommentsDescription,
    storageKey: Constants.allowCommentsStorageKey,
  );

  final String title;
  final String description;
  final String storageKey;
  const PostSetting({
    required this.title,
    required this.description,
    required this.storageKey,
  });
}
