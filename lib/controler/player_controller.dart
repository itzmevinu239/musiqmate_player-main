import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:musiq_player/db/functions/dbfunctions.dart';
import 'package:musiq_player/db/model/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import '../notifirelist/songNotifierList.dart';

final audioquery = OnAudioQuery();
final audioPlayer = AssetsAudioPlayer();

List<SongModel> allsongslist = [];
List<SongModel> flacsongslist = [];
List<Audio> audio = [];

fetchsongs() async {
  final permission = await Permission.storage.request();

  if (permission.isGranted) {
    allsongslist = await audioquery.querySongs();

    for (var element in allsongslist) {
      if (element.fileExtension == 'flac') {
        flacsongslist.add(element);
      }
    }

    for (var elements in flacsongslist) {
      allsongsAdddb(elements);
    }
  } else {
    fetchsongs();
  }
  allsongsdatashowList();
}

playsongs(index, List<songsmodel> songlist) {
  bool isPlaying = true;
  isSongPlayingNotifier.value = isPlaying;
  isSongPlayingNotifier.notifyListeners();
  audio.clear();
  for (var elements in songlist) {
    audio.add(Audio.file(elements.uri,
        metas: Metas(
            id: elements.id.toString(),
            artist: elements.artistName,
            title: elements.songName)));
  }
  audioPlayer.open(Playlist(audios: audio, startIndex: index),
      autoStart: true, showNotification: true, loopMode: LoopMode.playlist);
}
