class ChatContact {
  final String name;
  final String profilePic;
  final String contactId;
  final DateTime timeSent;
  final String lastMessage;
  ChatContact({
    required this.name,
    required this.profilePic,
    required this.contactId,
    required this.timeSent,
    required this.lastMessage,
  });

  ChatContact copyWith({
    String? name,
    String? profilePic,
    String? contactId,
    DateTime? timeSent,
    String? lastMessage,
  }) {
    return ChatContact(
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      contactId: contactId ?? this.contactId,
      timeSent: timeSent ?? this.timeSent,
      lastMessage: lastMessage ?? this.lastMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profilePic': profilePic,
      'contactId': contactId,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'lastMessage': lastMessage,
    };
  }

  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      contactId: map['contactId'] ?? '',
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      lastMessage: map['lastMessage'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ChatContact(name: $name, profilePic: $profilePic, contactId: $contactId, timeSent: $timeSent, lastMessage: $lastMessage)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChatContact &&
        other.name == name &&
        other.profilePic == profilePic &&
        other.contactId == contactId &&
        other.timeSent == timeSent &&
        other.lastMessage == lastMessage;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profilePic.hashCode ^
        contactId.hashCode ^
        timeSent.hashCode ^
        lastMessage.hashCode;
  }
}
