import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/providers/message_reply_provider.dart';
import 'package:whatsapp_ui/widgets/display_file.dart';

class MessageReplyPreview extends ConsumerWidget {
  const MessageReplyPreview({super.key});
  void cancelReply(WidgetRef ref) {
    ref.read(MessageReplyProvider.notifier).update((state) => null);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageReply = ref.watch(MessageReplyProvider);
    return Container(
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12))),
      width: 350,
      padding: const EdgeInsets.all(8),
      child: Column(children: [
        Row(
          children: [
            Expanded(
                child: Text(
              messageReply!.isME ? 'ME' : 'OPPOSITE',
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
            GestureDetector(
              child: const Icon(
                Icons.close,
                size: 16,
              ),
              onTap: () {
                ref
                    .watch(MessageReplyProvider.notifier)
                    .update((state) => null);
              },
            )
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        DisplayFile(
          message: messageReply.message,
          type: messageReply.messageEnum,
        )
      ]),
    );
  }
}
