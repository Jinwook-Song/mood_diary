import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostCard extends StatelessWidget {
  final String mood;
  final String diary;
  final int createdAt;
  const PostCard({
    super.key,
    required this.mood,
    required this.diary,
    required this.createdAt,
  });

  String get _timeFormat {
    return DateFormat.yMMMMEEEEd()
        .add_jm()
        .format(DateTime.fromMillisecondsSinceEpoch(createdAt));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: Colors.teal.shade400,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black,
                  spreadRadius: 1,
                  blurRadius: 0.1,
                  offset: Offset(-1, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mood: $mood'),
                Text(diary),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Opacity(opacity: 0.5, child: Text(_timeFormat))
        ],
      ),
    );
  }
}
