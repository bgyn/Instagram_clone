import 'dart:typed_data';
import 'package:flutter/material.dart' as material show Image;
import 'package:instagram_clone/states/image_upload/extension/get_image_ascept_ratio.dart';

extension GetImageDataAsceptRatio on Uint8List {
  Future<double> getAsceptRatio() {
    final image = material.Image.memory(this);
    return image.getAsceptRatio();
  }
}
