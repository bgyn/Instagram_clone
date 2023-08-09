import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/image_upload/notifier/image_upload_notifer.dart';
import 'package:instagram_clone/states/image_upload/type_def/is_loading.dart';

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, IsLoading>(
  (ref) => ImageUploadNotifier(),
);
