import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';
import 'package:whatsapp_ui/common/providers/message_reply_provider.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_ui/feature/chat/repository/chat_repository.dart';
import 'package:whatsapp_ui/models/chat_contact.dart';
import 'package:whatsapp_ui/models/message.dart';
import 'package:whatsapp_ui/models/user_model.dart';

//chatcontrollerprovider
final chatControllerProvider = Provider((ref) {
  final chatRepository = ref.read(chatRepositoryProvider);
  return ChatController(chatRepository: chatRepository, ref: ref);
});

class ChatController {
  final ChatRepository chatRepository;
  final ProviderRef ref;

  ChatController({required this.chatRepository, required this.ref});

  void sendTextMessage(
    BuildContext context,
    String text,
    String receiverUserId,
  ) {
    final messageReply = ref.read(MessageReplyProvider);
    ref.read(userauthProvider).whenData((value) =>
        chatRepository.sendTextMessage(
            messageReply: messageReply,
            context: context,
            text: text,
            receiverUserId: receiverUserId,
            senderUser: value!));

    ref.read(MessageReplyProvider.state).update((state) => null);
  }

  void sendFileMessage(
      {required BuildContext context,
      required File file,
      required receiverUserId,
      required MessageEnum messageType}) async {
    final messageReply = ref.read(MessageReplyProvider);
    ref.read(userauthProvider).whenData((value) =>
        chatRepository.sendFileMessage(
            messageReply: messageReply,
            context: context,
            file: file,
            receiverUserId: receiverUserId,
            senderUserData: value!,
            ref: ref,
            messageType: messageType));
    ref.read(MessageReplyProvider.state).update((state) => null);
  }

  Stream<List<ChatContact>> getChatContacts() {
    return chatRepository.getChatContacts();
  }

  Stream<List<Message>> getChatStream(String receiverUserID) {
    return chatRepository.getChatStream(receiverUserID);
  }

  void sendGIFMessage({
    required BuildContext context,
    required String gifUrl,
    required String receiverUserId,
  }) async {
    final messageReply = ref.read(MessageReplyProvider);

    int gifUrlPartIndex = gifUrl.lastIndexOf('-') + 1;
    String gifUrlPart = gifUrl.substring(gifUrlPartIndex);
    String newGifUrl = 'https://i.giphy.com/media/$gifUrlPart/200.gif';
    ref.read(userauthProvider).whenData((value) =>
        chatRepository.sendGIFMessage(
            messageReply: messageReply,
            context: context,
            gifUrl: newGifUrl,
            receiverUserId: receiverUserId,
            senderUser: value!));
    ref.read(MessageReplyProvider.state).update((state) => null);
  }

  void setChatMsgSeen(
      BuildContext context, String receiverUserId, String messageId) async {
    chatRepository.setChatMsgSeen(context, receiverUserId, messageId);
  }
}
