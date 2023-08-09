import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/image_upload/exception/could_not_build_thumbnail_exception.dart';
import 'package:instagram_clone/states/image_upload/extension/get_image_ascept_ratio.dart';
import 'package:instagram_clone/states/image_upload/models/file_type.dart';
import 'package:instagram_clone/states/image_upload/models/image_with_ascept_ratio.dart';
import 'package:instagram_clone/states/image_upload/models/thumbnail_request.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

final thumbnailProvider = FutureProvider.family
    .autoDispose<ImageWithAsceptRatio, ThumbnailRequest>(
        (ref, ThumbnailRequest request) async {
  final Image image;
  switch (request.fileType) {
    case FileType.image:
      image = Image.file(
        request.file,
        fit: BoxFit.fitHeight,
      );
      break;
    case FileType.video:
      final thumb = await VideoThumbnail.thumbnailData(
        video: request.file.path,
        imageFormat: ImageFormat.JPEG,
        quality: 75,
      );
      if (thumb == null) {
        throw const CouldNotBuildThumbnailException();
      }
      image = Image.memory(
        thumb,
        fit: BoxFit.fitHeight,
      );
      break;
  }
  final asceptRatio = await image.getAsceptRatio();
  return ImageWithAsceptRatio(
    image: image,
    asceptRatio: asceptRatio,
  );
});
