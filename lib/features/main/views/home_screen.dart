import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_diary/features/main/widgets/post_card.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  void _onLongPress(int index) {
    print(index);
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        title: const Text(
          'Delete note',
        ),
        message: const Text('Are you sure you want to do this?'),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => {},
            isDestructiveAction: true,
            child: const Text('Delete'),
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(context).pop(),
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('🔥 MOOD 🔥'),
      ),
      body: ListView.separated(
        itemCount: 20,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () => _onLongPress(index),
            child: PostCard(
                mood: '😍',
                diary:
                    'Today i feel amazing! I really like Flutter, I love building beautiful things!',
                createdAt: DateTime.now().millisecondsSinceEpoch),
          );
        },
      ),
    );
  }
}
