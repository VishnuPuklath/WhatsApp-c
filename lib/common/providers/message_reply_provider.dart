import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/common/enums/message_enum.dart';

class MessageReply {
  final String message;
  final bool isME;
  final MessageEnum messageEnum;

  MessageReply(
      {required this.message, required this.isME, required this.messageEnum});
}

final MessageReplyProvider = StateProvider<MessageReply?>((ref) => null);
