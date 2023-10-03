import 'dart:convert';

import 'package:whatsapp_ui/common/enums/message_enum.dart';

class Message {
  final String senderId;
  final String receiverId;
  final String text;
  final MessageEnum type;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;
  Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  Message copyWith({
    String? senderId,
    String? receiverId,
    String? text,
    MessageEnum? type,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
  }) {
    return Message(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
      type: type ?? this.type,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'type': type.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      text: map['text'] ?? '',
      type: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }

  @override
  String toString() {
    return 'Message(senderId: $senderId, receiverId: $receiverId, text: $text, type: $type, timeSent: $timeSent, messageId: $messageId, isSeen: $isSeen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Message &&
        other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.text == text &&
        other.type == type &&
        other.timeSent == timeSent &&
        other.messageId == messageId &&
        other.isSeen == isSeen;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        receiverId.hashCode ^
        text.hashCode ^
        type.hashCode ^
        timeSent.hashCode ^
        messageId.hashCode ^
        isSeen.hashCode;
  }
}
