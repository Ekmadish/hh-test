import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:test/feature/profile/view/profile_screen.dart';
import 'package:test/util/navigator_util.dart';

// Copyright (c) 2022 Estai Qargabai
//Sunday 8 Jan 2023
// flutter test
//★★ clean architecture | bloc | http | custom icon | infinite scroll view ... ★★

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _bootstrap();
  runApp(const AppRoot());
}

Future<void> _bootstrap() async {
  // do some  bootstrap thing...
}

class AppRoot extends StatelessWidget {
  const AppRoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Test',
        home: const SplashScreen(),
        theme: Theme.of(context).copyWith(
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                centerTitle: true,
                elevation: 0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto'),
                iconTheme: IconThemeData(color: Colors.black))));
  }
}

//Splash step
class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

//after animated navigate screen
  void _init(BuildContext context) async {
    Future.delayed(const Duration(milliseconds: 700), () {
      Navigator.pushAndRemoveUntil(
          context, transitionFade(const ProfileScreen()), (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
            child: const FlutterLogo(size: 44)
                .animate()
                .fade(duration: const Duration(milliseconds: 300))
                .scale(
                    begin: const Offset(2.3, 2.3),
                    end: const Offset(1, 1),
                    duration: const Duration(milliseconds: 700))
                .callback(callback: (_) {
          _init(context);
        })));
  }
}
