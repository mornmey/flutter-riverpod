import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hor_pao/screens/emoji/emoji_widget.dart';

class EmojiDetailWidget extends ConsumerWidget {
  const EmojiDetailWidget({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(emojiProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emoji Detail"),
      ),
      body: Center(
        child: currentWeather.when(
          data: (data) => Text(
            "Emoji: $data",
            style: const TextStyle(fontSize: 40),
          ),
          error: (_, __) => const Text(
            "Error",
          ),
          loading: () => const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
