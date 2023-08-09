import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as img;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/auth/constant/firebase_collection_name.dart';
import 'package:instagram_clone/states/image_upload/constants/constants.dart';
import 'package:instagram_clone/states/image_upload/exception/could_not_build_thumbnail_exception.dart';
import 'package:instagram_clone/states/image_upload/extension/get_collection_name_from_file_type.dart';
import 'package:instagram_clone/states/image_upload/extension/get_image_data_ascept_ratio.dart';
import 'package:instagram_clone/states/image_upload/models/file_type.dart';
import 'package:instagram_clone/states/image_upload/type_def/is_loading.dart';
import 'package:instagram_clone/states/post/models/post_payload.dart';
import 'package:instagram_clone/states/post/typedefs/user_id.dart';
import 'package:instagram_clone/states/post_settings/models/post_settings.dart';
import 'package:uuid/uuid.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class ImageUploadNotifier extends StateNotifier<IsLoading> {
  ImageUploadNotifier() : super(false);

  set isLoading(bool value) => state = value;
  Future<bool> upload({
    required File file,
    required FileType fileType,
    required String message,
    required Map<PostSetting, bool> postSettings,
    required UserId userId,
  }) async {
    isLoading = true;
    late Uint8List thumbnailUint8List;

    switch (fileType) {
      case FileType.image:
        final fileAsImage = img.decodeImage(file.readAsBytesSync());
        if (fileAsImage == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        }
        final thumbnail = img.copyResize(
          fileAsImage,
          width: Constants.imageThumnailWidth,
        );
        final thumbnailData = img.encodeJpg(thumbnail);
        thumbnailUint8List = Uint8List.fromList(thumbnailData);
        break;
      case FileType.video:
        final thumb = await VideoThumbnail.thumbnailData(
          video: file.path,
          imageFormat: ImageFormat.JPEG,
          maxHeight: Constants.videoThumbNailMaxHeight,
          quality: Constants.videoThumbNailQuality,
        );
        if (thumb == null) {
          isLoading = false;
          throw const CouldNotBuildThumbnailException();
        } else {
          thumbnailUint8List = thumb;
        }
        break;
    }
    //calculate the ascept ratio
    final thumnailAsceptRatio = await thumbnailUint8List.getAsceptRatio();

    //calculate refrence
    final fileName = const Uuid().v4();

    //create refrences to the thumbnail and image itself

    final thumbnailRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(FirebaseCollectionName.thumbnails)
        .child(fileName);

    final originalFileRef = FirebaseStorage.instance
        .ref()
        .child(userId)
        .child(fileType.getCollectionName)
        .child(fileName);
    try {
      //upload the thumbnail
      final thumbnailUploadTask =
          await thumbnailRef.putData(thumbnailUint8List);
      final thumbnailStorageId = thumbnailUploadTask.ref.name;

      //upload the orignal file
      final originalFileUploadTask = await originalFileRef.putFile(file);
      final originalStorageId = originalFileUploadTask.ref.name;

      //upload the post itself
      final postPayload = PostPayload(
          userId: userId,
          message: message,
          thumbnailUrl: await thumbnailRef.getDownloadURL(),
          fileUrl: await originalFileRef.getDownloadURL(),
          fileType: fileType,
          fileName: fileName,
          asceptRatio: thumnailAsceptRatio,
          thumbnailStorageId: thumbnailStorageId,
          originalFileStorageId: originalStorageId,
          postSetting: postSettings);
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.posts)
          .add(postPayload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}
