import '../../db/functions/newdbf.dart';
import '../../db/model/songsmodel.dart';
import '../../notifirelist/songNotifierList.dart';

void findsong(int id) {
  // print("sonngs" +id.toString());
  for (var element in allSongListNotifier.value) {
    if (element.id == id) {
      addrecentlyplayed(element);
      mostPlayedSongs(element);
      break;
    }
  }
}

songsmodel findsongwithid(int songid) {
  late songsmodel data;
  for (var element in allSongListNotifier.value) {
    if (songid == element.id) {
      data = element;
    }
  }

  return data;
}
