import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_ui/colors.dart';
import 'package:whatsapp_ui/common/widgets/error.dart';
import 'package:whatsapp_ui/common/widgets/loader.dart';
import 'package:whatsapp_ui/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_ui/feature/landing/screens/landing_screen.dart';
import 'package:whatsapp_ui/firebase_options.dart';
import 'package:whatsapp_ui/router.dart';
import 'package:whatsapp_ui/screens/mobile_layout_screen.dart';
import 'package:whatsapp_ui/screens/web_layout_screen.dart';
import 'package:whatsapp_ui/utils/responsive_layout.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      onGenerateRoute: (settings) => generateRoute(settings),
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI',
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(color: appBarColor),
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: ref.watch(userauthProvider).when(
            data: (user) {
              if (user == null) {
                return LandingScreen();
              }
              return MobileLayoutScreen();
            },
            error: (error, stackTrace) {
              return ErrorScreen(error: error.toString());
            },
            loading: () => const Loader(),
          ),
    );
  }
}
