import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:musiq_player/db/functions/newdbf.dart';
import 'package:musiq_player/db/model/playlistmodel.dart';
import 'package:flutter/material.dart';
import 'package:musiq_player/screens/NowPlaying/now_playing.dart';
import 'package:musiq_player/screens/playlist/playlist_song_listing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../controler/player_controller.dart';
import '../../db/functions/dbfunctions.dart';
import '../../db/model/songsmodel.dart';
import '../../notifirelist/songNotifierList.dart';

Widget headtext(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
  );
}

class songlistbar extends StatefulWidget {
  songlistbar(
      {super.key,
      required this.data,
      required this.index,
      required this.context,
      required this.songslist});

  songsmodel data;
  int index;
  BuildContext context;
  List<songsmodel> songslist;

  @override
  State<songlistbar> createState() => _songlistbarState();
}

class _songlistbarState extends State<songlistbar> {
  @override
  Widget build(BuildContext context) {
    bool isChecking = favouritecheckings(widget.data);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(50, 225, 225, 225)),
      child: ListTile(
        leading: QueryArtworkWidget(
          id: widget.data.id,
          type: ArtworkType.AUDIO,
          nullArtworkWidget: const CircleAvatar(
            backgroundImage: AssetImage('assets/Images/Logo.png'),
          ),
        ),
        title: TextScroll(
          widget.data.songName,
          velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.data.artistName,
          style: const TextStyle(color: Color.fromARGB(255, 203, 203, 203)),
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                callingBottomSheet(context, widget.data);
              },
              icon: const Icon(
                Icons.playlist_add,
                color: Colors.white,
              ),
            ),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (isChecking == false) {
                      addtofavdb(widget.data, context);
                    } else {
                      deletefrmfav(widget.data, context);
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
                      ))
          ],
        ),
        onTap: () {
          playsongs(widget.index, allSongListNotifier.value);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => miniplaye_r(

          //       ),
          //     ));
          //  now_Playing();
        },
      ),
    );
  }
}

class PlayListListing extends StatelessWidget {
  PlayListListing({
    super.key,
    required this.index,
    required this.data,
  });
  int index;
  final playlistmodel data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayListSongListing(
              data: data,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: const Color.fromARGB(0, 255, 255, 255),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: const DecorationImage(
                    image: AssetImage("assets/Images/bg2.jpg"),
                    fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              width: double.infinity,
              height: 44,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                    bottomLeft: Radius.circular(8)),
                color: Color.fromARGB(81, 255, 255, 255),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        data.playlistname,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          fontFamily: "FiraSansCondensed-Medium",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    InkWell(
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8)),
                          color: Color.fromARGB(102, 2, 162, 255),
                        ),
                        child: Center(
                          child: PopupMenuButton(
                              color: Colors.white,
                              itemBuilder: (context) => [
                                    PopupMenuItem(
                                        child: InkWell(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                        playlistdelete(data, context);
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('Delete Playlist'),
                                          Icon(Icons.delete)
                                        ],
                                      ),
                                    )),
                                    PopupMenuItem(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.of(context).pop();
                                          final obj2 = playlistnameupdate(
                                              context, index);
                                          obj2.createnewplayList(context);
                                        },
                                        child: const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('Change name'),
                                            Icon(Icons.edit)
                                          ],
                                        ),
                                      ),
                                    )
                                  ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}

//create playlist popup

class createnewplaylist {
  createnewplaylist(this.context);
  BuildContext context;
  final _formkey = GlobalKey<FormState>();
  final _playlisttextcontroller = TextEditingController();

  void createnewplayList(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Creat New Playlist",
          style: TextStyle(fontFamily: "BebasNeue-Regular", fontSize: 25),
        ),
        content: Form(
          key: _formkey,
          child: TextFormField(
            decoration:
                const InputDecoration(label: Text("Enter your playlist name")),
            controller: _playlisttextcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the playlist name';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _submitForm();
                  _playlisttextcontroller.clear();
                }
              },
              child: const Text(
                "Create",
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.black)))
        ],
      ),
    );
  }

  void _submitForm() {
    final textValue = _playlisttextcontroller.text;
    print('textcontroller = $textValue');
    List<songsmodel> listarray = [];
    addplaylisttodatabase(textValue, listarray, context);
    Navigator.pop(context);
  }
}

void callingBottomSheet(BuildContext context, songsmodel songdata) {
  addplaylistdbtovaluelistenable();
  final obj = createnewplaylist(context);
  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15),
      ),
    ),
    context: context,
    builder: (context) => Container(
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 230, 230, 230),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      height: 400,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Playlist',
                style: TextStyle(
                    // fontFamily: "BebasNeue-Regular",
                    fontSize: 30,
                    color: Color(0xFF3F9EFD),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                width: 200,
              ),
              IconButton(
                onPressed: () {
                  obj.createnewplayList(context);
                },
                icon: const Icon(Icons.add, color: Color(0xFF3F9EFD)),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: playlistnamenotifier,
                builder: (BuildContext context,
                    List<playlistmodel> playlistname, Widget? child) {
                  return playlistname.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: playlistname.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = playlistname[index];
                            return Container(
                                height: 65,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(86, 189, 189, 189),
                                    borderRadius: BorderRadius.circular(3)),
                                margin: const EdgeInsets.only(
                                    bottom: 5, right: 15, left: 15),
                                child: ListTile(
                                  leading: const Icon(
                                    Icons.folder_rounded,
                                    size: 50,
                                    color: Color(0xFF3F9EFD),
                                  ),
                                  title: TextScroll(
                                    data.playlistname,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        overflow: TextOverflow.ellipsis,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  tileColor:
                                      const Color.fromARGB(0, 136, 136, 136)
                                          .withOpacity(0.3),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    songaddtoplaylistdatabase(
                                        data.playlistname, songdata, context);
                                  },
                                ));
                          },
                        )
                      : const Center(
                          child: Text("No Play List Add"),
                        );
                }),
          ),
        ],
      ),
    ),
  );
}

void callingBottomSheetsonglisting(BuildContext context, String listname) {
  addplaylistdbtovaluelistenable();

  showModalBottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    context: context,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text(
              'ALLSONGS',
              style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF3F9EFD),
                  fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: allSongListNotifier.value.length,
              itemBuilder: (BuildContext context, int index) {
                final data = allSongListNotifier.value[index];
                return Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(97, 189, 189, 189),
                        borderRadius: BorderRadius.circular(8)),
                    margin:
                        const EdgeInsets.only(bottom: 5, right: 15, left: 15),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      leading: QueryArtworkWidget(
                        id: data.id,
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: const CircleAvatar(
                          backgroundImage: AssetImage('assets/Images/Logo.png'),
                        ),
                      ),
                      title: TextScroll(
                        data.songName,
                      ),
                      subtitle: Text(
                        data.artistName,
                        overflow: TextOverflow.ellipsis,
                      ),
                      tileColor: const Color.fromARGB(0, 136, 136, 136)
                          .withOpacity(0.3),
                      trailing: IconButton(
                          onPressed: () {
                            songaddtoplaylistdatabase(listname, data, context);
                          },
                          icon: checkplaylist(data)
                              ? const Icon(
                                  Icons.minimize,
                                  color: Color(0xFF3F9EFD),
                                )
                              : const Icon(
                                  Icons.add,
                                  color: Color(0xFF3F9EFD),
                                )),
                    ));
              },
            ),
          ),
        ],
      ),
    ),
  );
}

class playlistnameupdate {
  playlistnameupdate(this.context, this.index);
  BuildContext context;
  int index;

  final _formkey = GlobalKey<FormState>();
  final _playlisttexcontroller = TextEditingController();
  void createnewplayList(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Playlist cration",
          style: TextStyle(fontFamily: "BebasNeue-Regular", fontSize: 25),
        ),
        content: Form(
          key: _formkey,
          child: TextFormField(
            decoration: const InputDecoration(
                label: Text("Enter your new playlist name")),
            controller: _playlisttexcontroller,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter the playlist name';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                if (_formkey.currentState!.validate()) {
                  _submitForm();
                }
              },
              child: const Text(
                "Change",
                style: TextStyle(color: Colors.black),
              )),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.black)))
        ],
      ),
    );
  }

  void _submitForm() {
    final textValue = _playlisttexcontroller.text;
    // print('textcontroller = $textValue');
    List<songsmodel> listarray = [];
    playlistrename(textValue, listarray, context, index);
    Navigator.pop(context);
  }
}

// music player Slider......

class Musicsliders extends StatefulWidget {
  const Musicsliders({super.key});

  @override
  State<Musicsliders> createState() => _MusicslidersState();
}

class _MusicslidersState extends State<Musicsliders> {
  double slidervalue = 0;

  double duration = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    audioPlayer.current.listen((event) {
      final totalduration = event!.audio.duration;
      duration = event.audio.duration.inSeconds.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlayerBuilder.currentPosition(
      player: audioPlayer,
      builder: (context, position) {
        slidervalue = position.inSeconds.toDouble();

        return Column(
          children: [
            Slider(
              thumbColor: const Color.fromARGB(255, 255, 255, 255),
              activeColor: const Color.fromARGB(255, 172, 103, 247),
              inactiveColor: Colors.white,
              value: slidervalue,
              min: 0.0,
              max: duration,
              onChanged: (value) {
                slidervalue = value;
                audioPlayer.seek(Duration(seconds: slidervalue.toInt()));
              },
            ),
          ],
        );
      },
    );
  }
}

class Recentlyplayedandmostplayed extends StatefulWidget {
  Recentlyplayedandmostplayed(
      {super.key,
      required this.data,
      required this.index,
      required this.newlist});
  songsmodel data;
  int index;
  List<songsmodel> newlist;

  @override
  State<Recentlyplayedandmostplayed> createState() =>
      _RecentlyplayedandmostplayedState();
}

class _RecentlyplayedandmostplayedState
    extends State<Recentlyplayedandmostplayed> {
  @override
  Widget build(BuildContext context) {
    bool isChecking = favouritecheckings(widget.data);
    return ListTile(
      leading: QueryArtworkWidget(
        id: widget.data.id,
        type: ArtworkType.AUDIO,
        nullArtworkWidget: const CircleAvatar(
          backgroundImage: AssetImage('assets/Images/Logo.png'),
          radius: 25,
        ),
      ),
      title: TextScroll(
        velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
        widget.data.songName,
        style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold),
      ),
      subtitle: TextScroll(
        velocity: const Velocity(pixelsPerSecond: Offset(30, 0)),
        widget.data.artistName,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {
              callingBottomSheet(context, widget.data);
            },
            icon: const Icon(
              Icons.playlist_add,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (isChecking == false) {
                  addtofavdb(widget.data, context);
                } else {
                  deletefrmfav(widget.data, context);
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
          ),
        ],
      ),
      onTap: () {
        playsongs(widget.index, widget.newlist);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NowPlaying(
              data: widget.data,
            ),
          ),
        );
      },
    );
  }
}
