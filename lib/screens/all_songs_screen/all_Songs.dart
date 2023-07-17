import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musiq_player/db/functions/dbfunctions.dart';
import 'package:musiq_player/notifirelist/songNotifierList.dart';
import '../../db/model/songsmodel.dart';
import '../all_widgets_screen/widgets.dart';

class all_songs extends StatefulWidget {
  const all_songs({super.key});

  @override
  State<all_songs> createState() => _all_songsState();
}

final AssetsAudioPlayer audioPlayer = AssetsAudioPlayer.withId('0');

class _all_songsState extends State<all_songs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allsongsfavlistshow();
  }

  late List<songsmodel> songsdisplaylist =
      List<songsmodel>.from(allSongListNotifier.value);

  Icon cusIcon = const Icon(Icons.search_rounded);
  Widget cusSearchBar = const Text('All Songs');

  void navigateBottomBar(int index) {
    setState(() {});
  }

  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    allsongsdatashowList();
    addplaylistdbtovaluelistenable();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        height: MediaQuery.of(context).size.height*0.3,
        width: MediaQuery.of(context).size.width*0.2,
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
            title: cusSearchBar,
            titleTextStyle: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
                fontWeight: FontWeight.w500),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(0, 255, 255, 255),
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: ValueListenableBuilder(
                valueListenable: allSongListNotifier,
                builder: (BuildContext context, List<songsmodel> newlist,
                    Widget? child) {
                  return newlist.isNotEmpty
                      ? ListView.builder(
                          itemCount: newlist.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final data = newlist[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 5),
                              child: songlistbar(
                                  data: data,
                                  index: index,
                                  context: context,
                                  songslist: newlist),
                            );
                          })
                      : const Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "No songs found",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                }),
          ),
        ),
      ),
    );
  }

  void songsearch(String value) {
    songsdisplaylist.clear;
    setState(() {
      songsdisplaylist = allSongListNotifier.value
          .where((element) =>
              element.songName.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    });
  }
}
