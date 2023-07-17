import 'package:flutter/material.dart';
import 'package:musiq_player/notifirelist/songNotifierList.dart';
import '../../db/functions/dbfunctions.dart';
import '../../db/model/playlistmodel.dart';
import '../all_widgets_screen/widgets.dart';

// ignore: camel_case_types
class Playlist_Listing extends StatefulWidget {
 const Playlist_Listing({
    super.key,
  });

  @override
  State<Playlist_Listing> createState() => Playlist_ListingState();
}

// ignore: camel_case_types
class Playlist_ListingState extends State<Playlist_Listing> {
  @override
  Widget build(BuildContext context) {
    addplaylistdbtovaluelistenable();
    final obj = createnewplaylist(context);
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xFF8028DF), Color(0xFF3F9EFD)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Playlists',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  obj.createnewplayList(context);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
          child: ValueListenableBuilder(
              valueListenable: playlistnamenotifier,
              builder: (BuildContext context, List<playlistmodel> playlistname,
                  Widget? child) {
                return playlistname.isNotEmpty
                    ? GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 25,
                                crossAxisSpacing: 10),
                        itemCount: playlistname.length,
                        itemBuilder: (context, index) {
                          final data = playlistname[index];

                          return OverflowBox(
                            maxHeight: 250 + 70,
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: PlayListListing(
                                index: index,
                                data: data,
                              ),
                            ),
                          );
                        },
                      )
                    : const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              "NO PLAYLIST",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      );
              }),
        ),
      ),
    );
  }
}
