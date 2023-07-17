import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiq_player/screens/NowPlaying/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../controler/player_controller.dart';
import '../../db/functions/dbfunctions.dart';
import '../../db/model/songsmodel.dart';
import '../../notifirelist/songNotifierList.dart';
import '../all_widgets_screen/widgets.dart';

class search_screen extends StatefulWidget {
  const search_screen({super.key});

  @override
  State<search_screen> createState() => _search_screenState();
}

class _search_screenState extends State<search_screen> {
  late List<songsmodel> songsdisplaylist =
      List<songsmodel>.from(allSongListNotifier.value);

  final _searchController = TextEditingController();
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
            'Search',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: const Color.fromARGB(63, 255, 255, 255),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Search Here',
                    hintStyle: const TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 0.586)),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(color: Color(0xFF3F9EFD))),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  controller: _searchController,
                  cursorColor: const Color.fromARGB(255, 76, 0, 255),
                  onChanged: (value) {
                    songsearch(value);
                  },
                ),
              ),
              const SizedBox(height: 20),
              songsdisplaylist.isNotEmpty
                  ? ListView.builder(
                      itemCount: songsdisplaylist.length,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final data = songsdisplaylist[index];
                        bool isChecking = favouritecheckings(data);
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color.fromARGB(50, 255, 255, 255)),
                          margin: const EdgeInsets.only(
                            bottom: 5,
                          ),
                          child: ListTile(
                            leading: QueryArtworkWidget(
                              id: data.id,
                              type: ArtworkType.AUDIO,
                              nullArtworkWidget: const CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/Images/Logo.png'),
                              ),
                            ),
                            title: TextScroll(
                              data.songName,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data.artistName,
                              style: const TextStyle(
                                  color: Color.fromARGB(195, 255, 255, 255)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                    onPressed: () =>
                                        callingBottomSheet(context, data),
                                    icon: const Icon(
                                      Icons.list,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (isChecking == false) {
                                        addtofavrourite(data, context);
                                      } else {
                                        deletefevsong(data, context);
                                      }
                                    });
                                  },
                                  icon: isChecking == true
                                      ? const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.favorite_outline_outlined,
                                          color: Colors.white,
                                        ),
                                )
                              ],
                            ),
                            onTap: () {
                              playsongs(index, songsdisplaylist);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => now_Playing(
                                    data: data,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      })
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'No match found',
                            style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 255, 255, 255)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
            ]),
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
              element.songName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void cleartext() {
    setState(() {
      _searchController.clear();
    });
  }
}
