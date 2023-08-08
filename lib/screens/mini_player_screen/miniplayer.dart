import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:musiq_player/controler/player_controller.dart';
import 'package:musiq_player/screens/NowPlaying/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:text_scroll/text_scroll.dart';
import '../screenFunction/screen_function.dart';

class Miniplayer extends StatefulWidget {
  const Miniplayer({super.key});

  @override
  State<Miniplayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<Miniplayer> {
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return audioPlayer.builderCurrent(builder: (cntx, playing) {
      int songid = int.parse(playing.audio.audio.metas.id!);
      findsong(songid);
      return SizedBox(
        height: 70,
        child: GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NowPlaying()));
          },
          child: ListTile(
            tileColor: Colors.amberAccent,
            leading: CircleAvatar(
              child: QueryArtworkWidget(
                artworkBorder: BorderRadius.circular(2),
                id: int.parse(playing.audio.audio.metas.id!),
                type: ArtworkType.AUDIO,
                nullArtworkWidget: const CircleAvatar(
                  backgroundImage: AssetImage("assets/Images/Logo.png"),
                ),
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextScroll(
                        playing.audio.audio.metas.title!,
                        velocity:
                            const Velocity(pixelsPerSecond: Offset(30, 0)),
                        pauseBetween: const Duration(milliseconds: 1000),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      TextScroll(
                        playing.audio.audio.metas.artist!,
                        velocity: const Velocity(
                          pixelsPerSecond: Offset(30, 0),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    audioPlayer.previous();
                  },
                  color: const Color.fromARGB(255, 0, 0, 0),
                  icon: const Icon(Icons.skip_previous_rounded),
                ),
                PlayerBuilder.isPlaying(
                  player: audioPlayer,
                  builder: (context, isPlaying) {
                    return IconButton(
                        onPressed: () {
                          if (isPlaying) {
                            audioPlayer.pause();
                          } else {
                            audioPlayer.play();
                          }
                        },
                        // iconSize: 30,
                        color: const Color.fromARGB(255, 0, 0, 0),
                        icon: isPlaying
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow));
                  },
                ),
                IconButton(
                    onPressed: () {
                      audioPlayer.next();
                    },
                    color: const Color.fromARGB(255, 0, 0, 0),
                    // iconSize: 35,
                    icon: const Icon(Icons.skip_next_rounded)),
              ],
            ),
          ),
        ),
      );
    });
  }
}
