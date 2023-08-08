import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/states/post/providers/user_post_provider.dart';
import 'package:instagram_clone/views/component/animation/empty_content_with_text_animation.dart';
import 'package:instagram_clone/views/component/animation/error_animation_view.dart';
import 'package:instagram_clone/views/component/animation/loading_animation_view.dart';
import 'package:instagram_clone/views/component/post/post_grid_view.dart';
import 'package:instagram_clone/views/constants/string.dart';

class UserPostView extends ConsumerWidget {
  const UserPostView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final post = ref.watch(userPostProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(userPostProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: post.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentWithTextAnimationView(
                text: Strings.youHaveNoPosts);
          } else {
            return PostGridView(posts: posts);
          }
        },
        error: (error, stackTrace) {
          return const ErrorAnimationView();
        },
        loading: () {
          return const LoadingAnimationView();
        },
      ),
    );
  }
}
