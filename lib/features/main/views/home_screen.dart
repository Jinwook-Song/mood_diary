import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mood_diary/features/main/view_models/post_delete.dart';
import 'package:mood_diary/features/main/view_models/post_load.dart';
import 'package:mood_diary/features/main/widgets/post_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> _onDelete({
    required String postId,
    required String creatorUid,
  }) async {
    await ref.read(postDeleteProvider.notifier).deletePost(
          context: context,
          postId: postId,
          creatorUid: creatorUid,
        );
    if (context.mounted) {
      context.pop();
    }
  }

  void _onLongPress({required String postId, required String creatorUid}) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text(
          'Delete note',
        ),
        message: const Text('Are you sure you want to do this?'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => _onDelete(postId: postId, creatorUid: creatorUid),
            isDestructiveAction: true,
            child: const Text('Delete'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => context.pop(),
          isDestructiveAction: false,
          child: const Text(
            'Cancel',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(postLoadProvider).when(
        loading: () => const CircularProgressIndicator.adaptive(),
        error: (error, stackTrace) => Center(
              child: Text(error.toString()),
            ),
        data: (data) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('🔥 MOOD 🔥'),
            ),
            body: ListView.separated(
              itemCount: data.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => _onLongPress(
                    postId: data[index].id,
                    creatorUid: data[index].creatorUid,
                  ),
                  child: PostCard(
                      mood: data[index].mood,
                      diary: data[index].diary,
                      createdAt: data[index].createdAt),
                );
              },
            ),
          );
        });
  }
}
