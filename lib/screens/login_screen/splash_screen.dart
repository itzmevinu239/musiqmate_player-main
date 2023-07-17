import 'dart:async';

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:musiq_player/navbar/main_page.dart';
import 'package:musiq_player/screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class splash_main extends StatefulWidget {
  const splash_main({super.key});

  @override
  State<splash_main> createState() => _splash_mainState();
}

class _splash_mainState extends State<splash_main> {
  double tern = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 3), () {
      checkbool(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
        splashIconSize: 220,
        splash: Center(
          child: Image.asset('assets/Images/Logo.png'),
        ),
        backgroundColor: const Color(0xFF8028DF),
        nextScreen: nav_Main_Page());
  }
}

checkbool(context) async {
  final sharedpre = await SharedPreferences.getInstance();
  final check = sharedpre.getBool("check");
  Navigator.of(context).pushReplacement(MaterialPageRoute(
    builder: (context) =>
        check == null ? const SplashScreen() : nav_Main_Page(),
  ));
}
