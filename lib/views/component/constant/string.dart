import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const allowLikesTitlel = 'Allow likes';
  static const allowLikesDescription =
      'By allowing likes, users will be able to press the like button on your post.';
  static const allowLikesStorageKey = 'allow likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription =
      'By allowing comments, users will be able to comment on your post.';
  static const allowCommentsStorageKey = 'allow comments';

  static const comment = 'comment';
  static const loading = 'loading...';
  static const person = 'person';
  static const likedThis = 'liked this';

  static const delete = 'Delete';
  static const areYouSureYouWantToDeleteThis =
      'Are your sure you want to delete this';

  static const logOut = 'Log Out';
  static const areYouSureYouWantToLogOutFromThisApp =
      'Are your sure you want to log out from this app';
  static const cancel = 'cancel';
  const Strings._();
}
