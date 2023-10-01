import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_diary/features/main/models/post_model.dart';

class PostRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createPostDocument(PostModel post) async {
    await _firestore.collection('posts').add(post.toJson());
  }

  Future<void> deletePostDocument(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchPosts() {
    final query =
        _firestore.collection("posts").orderBy("createdAt", descending: true);
    return query.get();
  }
}

final postRepo = Provider((ref) => PostRepo());
