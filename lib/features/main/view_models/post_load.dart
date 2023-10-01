import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_diary/features/main/models/post_model.dart';
import 'package:mood_diary/features/main/repos/post_repo.dart';

class PostLoadViewModel extends AsyncNotifier<List<PostModel>> {
  late final PostRepo _postRepo;
  List<PostModel> _list = [];

  @override
  FutureOr<List<PostModel>> build() async {
    _postRepo = ref.read(postRepo);
    _list = await _fetchPosts();
    return _list;
  }

  Future<List<PostModel>> _fetchPosts() async {
    final posts = await _postRepo.fetchPosts();
    return posts.docs
        .map(
          (doc) => PostModel.fromJson(
            json: doc.data(),
            postId: doc.id,
          ),
        )
        .toList();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    final posts = await _fetchPosts();
    _list = posts;
    state = AsyncValue.data(_list);
  }
}

final postLoadProvider =
    AsyncNotifierProvider<PostLoadViewModel, List<PostModel>>(
  () => PostLoadViewModel(),
);
