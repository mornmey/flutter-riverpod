import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hor_pao/screens/emoji/emoji_detail_widget.dart';

enum Emojis {
  hasha,
  joy,
  cry,
}

typedef Emoji = String;

Future<Emoji> getEmoji(Emojis city) {
  return Future.delayed(
    const Duration(seconds: 1),
    () => {
      Emojis.hasha: '🤣',
      Emojis.joy: '😂',
      Emojis.cry: '😢',
    }[city]!,
  );
}

// UI writes to and reads from this
final currentEmojiProvider = StateProvider<Emojis?>((ref) => null);

const unknownEmoji = '😝';

// UI reads this
final emojiProvider = FutureProvider.autoDispose<Emoji>((ref) {
  final city = ref.watch(currentEmojiProvider);
  if (city != null) {
    return getEmoji(city);
  } else {
    return unknownEmoji;
  }
});

class EmojiWidget extends ConsumerWidget {
  const EmojiWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emoji'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Emojis.values.length,
              itemBuilder: (context, index) {
                final city = Emojis.values[index];
                final isSelected = city == ref.watch(currentEmojiProvider);

                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const EmojiDetailWidget(),
                      ),
                    );
                    ref.read(currentEmojiProvider.notifier).state = city;
                  },
                  title: Text(city.toString()),
                  trailing: isSelected ? const Icon(Icons.done_all) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
