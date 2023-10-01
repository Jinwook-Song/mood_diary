import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mood_diary/common/widgets/button.dart';
import 'package:mood_diary/features/main/view_models/post_upload.dart';
import 'package:mood_diary/main.dart';

const List<String> moods = [
  '😅',
  '😍',
  '🥲',
  '😪',
  '🤮',
  '🥺',
  '😨',
  '😡',
  '😋',
];

class WriteScreen extends ConsumerStatefulWidget {
  const WriteScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _WriteScreenState();
}

class _WriteScreenState extends ConsumerState<WriteScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String? _mood;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _onMoodTap(String mood) {
    _mood = mood;
    setState(() {});
  }

  void _onSubmit() {
    if (_mood == null) return;
    ref.read(postUploadProvider.notifier).uploadPost(
          context: context,
          mood: _mood!,
          diary: _textEditingController.text,
        );
    _onScaffoldTap();
    _textEditingController.text = '';
    _mood = null;
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(postUploadProvider).isLoading;
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('🔥 MOOD 🔥'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'How do you feel?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: BaseColor,
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        spreadRadius: 1,
                        blurRadius: 0,
                        offset: Offset(-0.5, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    maxLines: 4,
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(12),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        hintText: 'Write it down here!'),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'What\'s your mood?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (final mood in moods)
                      GestureDetector(
                        onTap: () => _onMoodTap(mood),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: mood == _mood ? 36 : 32,
                          height: mood == _mood ? 36 : 32,
                          decoration: BoxDecoration(
                            color: mood == _mood ? Colors.amber : Colors.white,
                            border: Border.all(
                              color: Colors.black,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black,
                                spreadRadius: 0.1,
                                blurRadius: 0,
                                offset: Offset(0, 1.5),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            mood,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                  ],
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48),
                  child: GestureDetector(
                      onTap: _onSubmit,
                      child: isLoading
                          ? const CircularProgressIndicator.adaptive()
                          : const Button(text: 'Post')),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
