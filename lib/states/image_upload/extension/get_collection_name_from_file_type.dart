import 'package:instagram_clone/states/image_upload/models/file_type.dart';

extension CollectionName on FileType {
  String get getCollectionName {
    switch (this) {
      case FileType.image:
        return 'images';
      case FileType.video:
        return 'videos';
    }
  }
}
