import 'package:flutter/material.dart';
import 'package:instagram_clone/states/post/models/post.dart';

class PostThumbnailView extends StatelessWidget {
  final Post post;
  final VoidCallback onTapped;
  const PostThumbnailView({
    super.key,
    required this.onTapped,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Image.network(
        post.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
