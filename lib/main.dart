import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:musiq_player/db/model/playlistmodel.dart';
import 'package:musiq_player/db/model/songsmodel.dart';
import 'package:flutter/services.dart';
import 'package:musiq_player/screens/login_screen/splash_screen.dart';

void main(List<String> args) {
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Color(0xFF8028DF)));
  Hive.initFlutter();
  if (!Hive.isAdapterRegistered(songsmodelAdapter().typeId)) {
    Hive.registerAdapter(songsmodelAdapter());
  }

  if (!Hive.isAdapterRegistered(playlistmodelAdapter().typeId)) {
    Hive.registerAdapter(playlistmodelAdapter());
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      // home:  SplashScreen(),
      home: const splash_main(),
    );
  }
}
