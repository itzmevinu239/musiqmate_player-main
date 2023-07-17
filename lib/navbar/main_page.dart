import 'package:flutter/material.dart';
import 'package:musiq_player/db/model/songsmodel.dart';
import 'package:musiq_player/navbar/main_nav_bar.dart';
import 'package:musiq_player/screens/mini_player_screen/miniplayer.dart';
import 'package:musiq_player/screens/searchScreen/search.dart';
import '../screens/all_songs_screen/all_Songs.dart';
import '../screens/ScreenLibrary/screenLibrary.dart';

class nav_Main_Page extends StatefulWidget {
  nav_Main_Page({super.key, this.data});
  songsmodel? data;

  @override
  State<nav_Main_Page> createState() => _nav_Main_PageState();
}

class _nav_Main_PageState extends State<nav_Main_Page> {
  List pages = [
    const all_songs(),
    const search_screen(),
    const library_Screen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: currentindexnotifier,
          builder: (context, int index, child) {
            return pages[index];
          },
        ),
      ),
      bottomNavigationBar: Wrap(
        children: [
          miniplaye_r(),
          const nav_bar(),
        ],
      ),
    );
  }
}
