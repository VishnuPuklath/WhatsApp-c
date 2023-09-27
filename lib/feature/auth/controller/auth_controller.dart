import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:whatsapp_ui/feature/auth/repository/auth_repository.dart';
import 'package:whatsapp_ui/models/user_model.dart';

final authControllerProvider = Provider((ref) {
  return AuthController(ref.read(authRepositoryProvider), ref);
});

final userauthProvider = FutureProvider((ref) {
  ref.read(authControllerProvider).getCurrentUserData();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController(
    this.authRepository,
    this.ref,
  );

  void signInWithPhone(String phoneNumber, BuildContext context) async {
    authRepository.signInWithPhone(phoneNumber, context);
  }

  void verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String OTP}) async {
    authRepository.verifyOTP(
        context: context, verificationId: verificationId, OTP: OTP);
  }

  void saveUserDataToFirebase(
      {required String name,
      required File? profilePic,
      required BuildContext context}) async {
    authRepository.saveUserDataToFirebase(
        name: name, profilePic: profilePic, ref: ref, context: context);
  }

  Future<UserModel?> getCurrentUserData() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }
}
