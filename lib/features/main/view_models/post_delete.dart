import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_diary/common/utils.dart';
import 'package:mood_diary/features/authentication/repos/auth_repo.dart';
import 'package:mood_diary/features/main/models/post_model.dart';
import 'package:mood_diary/features/main/repos/post_repo.dart';
import 'package:mood_diary/features/main/view_models/post_load.dart';

class PostDeleteViewModel extends AsyncNotifier<void> {
  late final AuthRepo _authRepo;
  late final PostRepo _postRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
    _postRepo = ref.read(postRepo);
  }

  Future<void> deletePost(
      {required BuildContext context,
      required String postId,
      required String creatorUid}) async {
    final uid = _authRepo.user!.uid;

    if (uid != creatorUid) {
      showErrorSnackBar(context, 'Not authorized');
      return;
    }

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _postRepo.deletePostDocument(postId);
        await ref.read(postLoadProvider.notifier).refresh();
      },
    );

    if (context.mounted) {
      if (state.hasError) {
        showFirebaseErrorSnackBar(context, state.error);
      } else {
        context.pop();
      }
    }
  }

  Future<void> uploadPost({
    required BuildContext context,
    required String mood,
    required String diary,
  }) async {
    final uid = _authRepo.user!.uid;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        final post = PostModel(
          id: '',
          creatorUid: uid,
          creator: 'Anonymous',
          createdAt: DateTime.now().millisecondsSinceEpoch,
          mood: mood,
          diary: diary,
        );
        await _postRepo.createPostDocument(post);
        await ref.read(postLoadProvider.notifier).refresh();
      },
    );

    if (context.mounted) {
      if (state.hasError) {
        showFirebaseErrorSnackBar(context, state.error);
      } else {
        context.pushReplacement('/home');
      }
    }
  }
}

final postDeleteProvider = AsyncNotifierProvider<PostDeleteViewModel, void>(
  () => PostDeleteViewModel(),
);
