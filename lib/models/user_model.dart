import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupId;
  UserModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
  });

  UserModel copyWith({
    String? name,
    String? uid,
    String? profilePic,
    bool? isOnline,
    String? phoneNumber,
    List<String>? groupId,
  }) {
    return UserModel(
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      isOnline: isOnline ?? this.isOnline,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      groupId: groupId ?? this.groupId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      profilePic: map['profilePic'] ?? '',
      isOnline: map['isOnline'] ?? false,
      phoneNumber: map['phoneNumber'] ?? '',
      groupId: List<String>.from(map['groupId']),
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, uid: $uid, profilePic: $profilePic, isOnline: $isOnline, phoneNumber: $phoneNumber, groupId: $groupId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.uid == uid &&
        other.profilePic == profilePic &&
        other.isOnline == isOnline &&
        other.phoneNumber == phoneNumber &&
        listEquals(other.groupId, groupId);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        uid.hashCode ^
        profilePic.hashCode ^
        isOnline.hashCode ^
        phoneNumber.hashCode ^
        groupId.hashCode;
  }
}
