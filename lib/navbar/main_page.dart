import 'package:flutter/material.dart';
import 'package:musiq_player/db/model/songsmodel.dart';
import 'package:musiq_player/navbar/main_nav_bar.dart';
import 'package:musiq_player/screens/mini_player_screen/miniplayer.dart';
import 'package:musiq_player/screens/searchScreen/search.dart';
import '../screens/all_songs_screen/all_Songs.dart';
import '../screens/ScreenLibrary/screenLibrary.dart';

// ignore: must_be_immutable
class NavMainPage extends StatefulWidget {
  NavMainPage({super.key, this.data});
  songsmodel? data;

  @override
  State<NavMainPage> createState() => _NavMainPageState();
}

class _NavMainPageState extends State<NavMainPage> {
  List pages = [
    const Allsongs(),
    const search_screen(),
    const LibraryScreen(),
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
      bottomNavigationBar: const Wrap(
        children: [
          Miniplayer(),
          NavBar(),
        ],
      ),
    );
  }
}
