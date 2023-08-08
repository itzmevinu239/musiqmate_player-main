import 'package:flutter/material.dart';
import 'package:musiq_player/notifirelist/songNotifierList.dart';
import 'package:musiq_player/screens/NowPlaying/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../controler/player_controller.dart';
import '../../db/functions/dbfunctions.dart';
import '../../db/model/songsmodel.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({
    super.key,
  });

  @override
  State<FavoriteList> createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
            'Favourits',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ValueListenableBuilder(
            valueListenable: favsongListNotifier,
            builder: (BuildContext context, List<songsmodel> favlist,
                Widget? child) {
              return favlist.isNotEmpty
                  ? ListView.builder(
                      itemCount: favlist.length,
                      shrinkWrap: true,
                      itemBuilder: (BuildContext context, int index) {
                        final data = favlist[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(40, 255, 255, 255),
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
                                          Color.fromARGB(192, 255, 255, 255)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: IconButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    deletefevsong(data, context);
                                  },
                                  icon:
                                      const Icon(Icons.delete_outline_rounded),
                                ),
                                onTap: () {
                                  playsongs(index, favlist);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => NowPlaying(
                                          data: data,
                                        ),
                                      ));
                                },
                              )),
                        );
                      },
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Text(
                          "NO SONGS",
                          style: TextStyle(
                              color: Color.fromARGB(137, 249, 249, 249),
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        )),
                      ],
                    );
            }),
      ),
    );
  }
}
