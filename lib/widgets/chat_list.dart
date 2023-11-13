import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';
import 'package:whatsapp_ui/common/providers/message_reply_provider.dart';

import 'package:whatsapp_ui/feature/chat/controller/chat_controller.dart';
import 'package:whatsapp_ui/models/message.dart';
import 'package:whatsapp_ui/widgets/my_message_card.dart';
import 'package:whatsapp_ui/widgets/sender_message_card.dart';

class ChatList extends ConsumerStatefulWidget {
  final String receiverUserId;

  ChatList({super.key, required this.receiverUserId});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<ChatList> {
  void onMessageSwipe(String message, bool isME, MessageEnum messageEnum) {
    ref.read(MessageReplyProvider.state).update((state) =>
        MessageReply(message: message, isME: isME, messageEnum: messageEnum));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: ref
            .watch(chatControllerProvider)
            .getChatStream(widget.receiverUserId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final message = snapshot.data![index];
              var timeSent = DateFormat.Hm().format(message.timeSent);
              if (!message.isSeen &&
                  message.receiverId ==
                      FirebaseAuth.instance.currentUser!.uid) {
                ref.read(chatControllerProvider).setChatMsgSeen(
                    context, widget.receiverUserId, message.messageId);
              }
              if (message.senderId == FirebaseAuth.instance.currentUser!.uid) {
                return MyMessageCard(
                  isSeen: message.isSeen,
                  repliedText: message.repliedMessage,
                  message: message.text,
                  date: timeSent,
                  type: message.type,
                  username: message.repliedTo,
                  repliedMessageType: message.repliedMessageType,
                  onLeftSwipe: () =>
                      onMessageSwipe(message.text, true, message.type),
                );
              }
              return SenderMessageCard(
                repliedMessageType: message.repliedMessageType,
                onRightSwipe: () =>
                    onMessageSwipe(message.text, false, message.type),
                repliedText: message.repliedMessage,
                username: message.repliedTo,
                type: message.type,
                message: message.text,
                date: timeSent,
              );
            },
          );
        });
  }
}
