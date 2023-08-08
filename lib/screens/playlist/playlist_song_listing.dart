import 'package:flutter/material.dart';
import 'package:musiq_player/db/functions/dbfunctions.dart';
import 'package:musiq_player/screens/all_widgets_screen/widgets.dart';
import 'package:musiq_player/db/model/playlistmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../controler/player_controller.dart';
import '../../db/model/songsmodel.dart';
import '../../notifirelist/songNotifierList.dart';
import 'package:musiq_player/screens/NowPlaying/now_playing.dart';

class PlayListSongListing extends StatefulWidget {
  PlayListSongListing({
    super.key,
    required this.data,
  });
  playlistmodel data;

  @override
  State<PlayListSongListing> createState() => _PlayListSongListingState();
}

class _PlayListSongListingState extends State<PlayListSongListing> {
  @override
  Widget build(BuildContext context) {
    playlistsongnotifier.value = widget.data.playlistarray;

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
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              widget.data.playlistname,
              style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 255, 255, 255)),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    callingBottomSheetsonglisting(
                        context, widget.data.playlistname);
                  },
                  icon: const Icon(Icons.add))
            ],
          ),
          backgroundColor: Colors.transparent,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15, left: 15, top: 10),
                child: ValueListenableBuilder(
                  valueListenable: playlistsongnotifier,
                  builder: (
                    BuildContext context,
                    List<songsmodel> playlistarrysongs,
                    Widget? child,
                  ) {
                    return playlistarrysongs.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: playlistarrysongs.length,
                            itemBuilder: (BuildContext context, int index) {
                              final data = playlistarrysongs[index];
                              return Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(50, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(8)),
                                margin: const EdgeInsets.only(bottom: 5),
                                child: ListTile(
                                  leading: QueryArtworkWidget(
                                    id: data.id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/Images/Logo.png'),
                                    ),
                                  ),
                                  title: Text(
                                    data.songName,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  subtitle: Text(
                                    data.artistName,
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 205, 205, 205)),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text('Alert'),
                                                  content: const Text(
                                                      'Are you sure you want to delete'),
                                                  actions: <Widget>[
                                                    ElevatedButton(
                                                      child: const Text('No'),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop(); // Close the alert dialog
                                                      },
                                                    ),
                                                    ElevatedButton(
                                                      child: const Text('Yes'),
                                                      onPressed: () {
                                                        // Perform an action
                                                        Navigator.of(context)
                                                            .pop();
                                                        songsdeletefromplaylist(
                                                            data,
                                                            widget.data
                                                                .playlistname);
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.delete_outline_rounded,
                                            color: Colors.white,
                                          )),
                                    ],
                                  ),
                                  onTap: () {
                                    playsongs(index, playlistarrysongs);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NowPlaying(
                                          data: data,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 350,
                              ),
                              Center(
                                child: Text(
                                  "NO SONGS",
                                  style: TextStyle(
                                      color: Color.fromARGB(137, 255, 255, 255),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
