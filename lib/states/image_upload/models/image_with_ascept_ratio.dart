import 'package:flutter/material.dart';

@immutable
class ImageWithAsceptRatio {
  final Image image;
  final double asceptRatio;
  const ImageWithAsceptRatio({
    required this.image,
    required this.asceptRatio,
  });
}
