import 'package:flutter/material.dart';
import 'package:musiq_player/db/model/songsmodel.dart';
import 'package:musiq_player/notifirelist/songNotifierList.dart';
import 'package:musiq_player/screens/playlist/playlist_listing.dart';
import '../../db/functions/dbfunctions.dart';
import '../../db/functions/newdbf.dart';
import '../favorite_songs_screen/favorite_list.dart';
import '../drawer_screen/main_drawer.dart';
import '../MostPlayed/most_played.dart';
import '../all_widgets_screen/widgets.dart';

class library_Screen extends StatefulWidget {
  const library_Screen({
    super.key,
  });

  @override
  State<library_Screen> createState() => _library_ScreenState();
}

class _library_ScreenState extends State<library_Screen> {
  void initState() {
    super.initState();
    allrecentlyplaylistshow();
    allsongsfavlistshow();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF8028DF), Color(0xFF3F9EFD)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Library',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        drawer: const main_drawer(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.5, right: 8.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    SizedBox(
                      width: 115,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Stack(children: [
                    const SizedBox(
                      width: 550,
                      height: 230,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Container(
                                width: 179,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                        'assets/Images/playlist.jpg',
                                      ),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(8),
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 170),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: const Color(0xFF3F9EFD),
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Center(
                                      child: Text(
                                        'Playlist',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                            letterSpacing: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const Playlist_Listing()));
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Container(
                                width: 179,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/Images/favourite.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 170),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xFF3F9EFD)),
                                    child: const Center(
                                      child: Text(
                                        'Favorite',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            letterSpacing: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => favorite_list()));
                              },
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              child: Container(
                                width: 179,
                                height: 200,
                                decoration: BoxDecoration(
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/Images/mostplayed.jpg'),
                                      fit: BoxFit.cover),
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 170),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: const Color(0xFF3F9EFD)),
                                    child: const Center(
                                      child: Text(
                                        'Most Played',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            letterSpacing: 1.5),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (contect) => const most_played(),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
                const SizedBox(
                  height: 8,
                ),
                const Text(
                  'Recently Played',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5),
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    ValueListenableBuilder(
                      valueListenable: recentlyPlayedNotifier,
                      builder: (BuildContext context,
                          List<songsmodel> recentlist, Widget? child) {
                        return recentlist.isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: recentlist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final data = recentlist[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            50, 255, 255, 255),
                                        borderRadius: BorderRadius.circular(8)),
                                    margin: const EdgeInsets.only(bottom: 8),
                                    child: recentlyplayedandmostplayed(
                                        data: data,
                                        index: index,
                                        newlist: recentlist),
                                  );
                                },
                              )
                            : const Column(
                                children: [
                                  SizedBox(
                                    height: 200,
                                  ),
                                  Center(
                                    child: Text(
                                      "NO SONGS",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              243, 255, 255, 255),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              );
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
