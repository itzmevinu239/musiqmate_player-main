import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:musiq_player/db/functions/newdbf.dart';
import 'package:musiq_player/screens/all_widgets_screen/widgets.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../../controler/player_controller.dart';
import '../../db/functions/dbfunctions.dart';
import '../../db/model/songsmodel.dart';
import '../screenFunction/screen_function.dart';

bool isshuffle = false;
bool isloop = false;

class NowPlaying extends StatefulWidget {
  const NowPlaying({
    super.key,
    this.data,
  });
  final songsmodel? data;

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  // final double _currentvalue = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.2,
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
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: audioPlayer.builderCurrent(
          builder: (context, playing) {
            int songid = int.parse(playing.audio.audio.metas.id!);
            findsong(songid);
            songsmodel songdata = findsongwithid(songid);
            bool ischeck = favouritecheckings(songdata);

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    SizedBox(
                      width: 350,
                      height: 350,
                      child: QueryArtworkWidget(
                        artworkBorder: BorderRadius.circular(10),
                        id: int.parse(playing.audio.audio.metas.id!),
                        type: ArtworkType.AUDIO,
                        nullArtworkWidget: ClipRect(
                          child: Image.asset('assets/Images/Logo.png'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8)),
                        width: double.infinity,
                        height: 100,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            TextScroll(
                              playing.audio.audio.metas.title!,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Color.fromARGB(255, 255, 255, 255),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextScroll(
                              playing.audio.audio.metas.artist!,
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const Musicsliders(),
                        Padding(
                          padding: const EdgeInsets.only(left: 22, right: 22),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlayerBuilder.currentPosition(
                                player: audioPlayer,
                                builder: (context, position) {
                                  final mm = (position.inMinutes % 60)
                                      .toString()
                                      .padLeft(2, '0');
                                  final ss = (position.inSeconds % 60)
                                      .toString()
                                      .padLeft(2, '0');
                                  return Text(
                                    '$mm:$ss',
                                    style: const TextStyle(color: Colors.white),
                                  );
                                },
                              ),
                              PlayerBuilder.current(
                                player: audioPlayer,
                                builder: (context, playing) {
                                  final totalduration = playing.audio.duration;
                                  final mm = (totalduration.inMinutes % 60)
                                      .toString()
                                      .padLeft(2, '0');
                                  final ss = (totalduration.inSeconds % 60)
                                      .toString()
                                      .padLeft(2, '0');
                                  return Text(
                                    '$mm:$ss',
                                    style: const TextStyle(color: Colors.white),
                                  );
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: (const Color.fromARGB(66, 255, 255, 255)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      audioPlayer
                                          .seekBy(const Duration(seconds: -10));
                                    },
                                    icon: const Icon(
                                      Icons.keyboard_double_arrow_left_rounded,
                                      size: 30,
                                    )),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      audioPlayer.previous();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.skip_previous,
                                    size: 32,
                                  ),
                                ),
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(60)),
                                  child: PlayerBuilder.isPlaying(
                                    player: audioPlayer,
                                    builder: (context, isPlaying) {
                                      return IconButton(
                                        onPressed: () {
                                          if (isPlaying == false) {
                                            audioPlayer.play();
                                          } else {
                                            audioPlayer.pause();
                                          }
                                        },
                                        icon: isPlaying == false
                                            ? const Icon(
                                                Icons.play_arrow_rounded,
                                                size: 60,
                                              )
                                            : const Icon(
                                                Icons.pause_rounded,
                                                size: 50,
                                              ),
                                      );
                                    },
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      audioPlayer.next();
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.skip_next,
                                    size: 32,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    audioPlayer
                                        .seekBy(const Duration(seconds: 10));
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_double_arrow_right_rounded,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 17, right: 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(70, 225, 225, 225),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (isshuffle == false) {
                                          audioPlayer.toggleShuffle();
                                          isshuffle = true;
                                        } else {
                                          audioPlayer.toggleShuffle();
                                          isshuffle = false;
                                        }
                                      });
                                    },
                                    icon: isshuffle == false
                                        ? const Icon(Icons.shuffle_rounded)
                                        : const Icon(
                                            Icons.shuffle_rounded,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(70, 225, 225, 225),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      callingBottomSheet(context, songdata);
                                    },
                                    icon: const Icon(
                                      Icons.playlist_add,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ),
                                ),
                              ),

                              //favourit button...
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(70, 225, 225, 225),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (ischeck == false) {
                                          addtofavdb(songdata, context);
                                        } else {
                                          deletefrmfav(songdata, context);
                                        }
                                      });
                                    },
                                    icon: ischeck == true
                                        ? const Icon(
                                            Icons.favorite,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.favorite_outline_outlined,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                  ),
                                ),
                              ),

                              //loop buttoon...
                              Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color:
                                      const Color.fromARGB(70, 225, 225, 225),
                                ),
                                child: Center(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        if (isloop == false) {
                                          audioPlayer
                                              .setLoopMode(LoopMode.single);
                                          isloop = true;
                                        } else {
                                          audioPlayer
                                              .setLoopMode(LoopMode.playlist);
                                          isloop = false;
                                        }
                                      });
                                    },
                                    icon: isloop == false
                                        ? const Icon(Icons.repeat)
                                        : const Icon(
                                            Icons.repeat,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
