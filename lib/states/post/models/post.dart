import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:instagram_clone/states/image_upload/models/file_type.dart';
import 'package:instagram_clone/states/post/models/post_key.dart';
import 'package:instagram_clone/states/post_settings/models/post_settings.dart';

@immutable
class Post {
  final String postId;
  final String userId;
  final String message;
  final DateTime createdAt;
  final String thumbnailUrl;
  final String fileUrl;
  final FileType fileType;
  final String fileName;
  final String aspectRatio;
  final String thumbnailStorageId;
  final String originalStorageId;
  final Map<PostSetting, bool> postSettings;
  Post({required this.postId, required Map<String, dynamic> json})
      : userId = json[PostKey.userId],
        message = json[PostKey.message],
        createdAt = (json[PostKey.createdAt] as Timestamp).toDate(),
        thumbnailUrl = json[PostKey.thumbnailUrl],
        fileUrl = json[PostKey.fileurl],
        fileType = FileType.values.firstWhere(
            (fileType) => fileType.name == json[PostKey.fileType],
            orElse: () => FileType.image),
        fileName = json[PostKey.fileName],
        aspectRatio = json[PostKey.aspectRatio],
        thumbnailStorageId = json[PostKey.thumbnailStorageId],
        originalStorageId = json[PostKey.originalFileStorageId],
        postSettings = {
          for (final entry in json[PostKey.postSettings].entries)
            PostSetting.values.firstWhere(
                    (element) => element.storageKey == entry.Key):
                entry.value,
        };
  bool get allowLikes => postSettings[PostSetting.allowsLikes] ?? false;
  bool get allowComments => postSettings[PostSetting.allowsComments] ?? false;
}
