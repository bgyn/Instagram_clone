import 'dart:async' show Completer;

import 'package:flutter/material.dart' as material
    show Image, ImageConfiguration, ImageStreamListener;

extension GetImageAsceptRatio on material.Image {
  Future<double> getAsceptRatio() async {
    final completer = Completer<double>();
    image
        .resolve(
      const material.ImageConfiguration(),
    )
        .addListener(
      material.ImageStreamListener(
        (imageInfo, synchronousCall) {
          final asceptRatio = imageInfo.image.width / imageInfo.image.height;
          imageInfo.image.dispose();
          completer.complete(asceptRatio);
        },
      ),
    );
    return completer.future;
  }
}
