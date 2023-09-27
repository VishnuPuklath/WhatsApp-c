import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/feature/auth/controller/auth_controller.dart';

class OTPScreen extends ConsumerWidget {
  static const routeName = '/otp-screen';
  final String verificationId;
  const OTPScreen({Key? key, required this.verificationId}) : super(key: key);

  void verifyOTP(BuildContext context, String OTP, WidgetRef ref) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context: context, verificationId: verificationId, OTP: OTP);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColor,
        title: const Text('Verifying your number'),
      ),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
            height: 20,
          ),
          const Text('We have sent an SMS with a code.'),
          SizedBox(
            width: size.width * 0.5,
            child: TextField(
              onChanged: (value) {
                if (value.length == 6) {
                  verifyOTP(context, value.trim(), ref);
                }
              },
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                  hintText: '- - - - - -', hintStyle: TextStyle(fontSize: 30)),
            ),
          )
        ]),
      ),
    );
  }
}
