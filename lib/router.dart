import 'package:flutter/material.dart';
import 'package:whatsapp_ui/common/widgets/error.dart';
import 'package:whatsapp_ui/feature/auth/screens/login_screen.dart';
import 'package:whatsapp_ui/feature/auth/screens/otp_screen.dart';
import 'package:whatsapp_ui/feature/auth/screens/user_information_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );
    case OTPScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OTPScreen(verificationId: verificationId),
      );
    case UserInformationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserInformationScreen(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const Scaffold(
            body: ErrorScreen(error: 'This Page doesn\'t exist')),
      );
  }
}
