import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:musiq_player/db/model/songsmodel.dart';
import 'package:musiq_player/notifirelist/songNotifierList.dart';

addtofavdb(songsmodel data, context) async {
  final addfavdb = await Hive.openBox<songsmodel>('favlistdb');

  bool check = false;

  for (var element in addfavdb.values) {
    if (data.id == element.id) {
      check = true;
    }
  }
  if (check == false) {
    addfavdb.add(data);
    favsongListNotifier.notifyListeners();
    allSongListNotifier.notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Song added to favourits...'),
    ));
  }
  allsongshowfavlist();
}

deletefrmfav(songsmodel data, context) async {
  final favdbdlt = await Hive.openBox<songsmodel>('favlistdb');
  int count = 0;

  for (var element in favdbdlt.values) {
    if (data.id == element.id) {
      favdbdlt.deleteAt(count);
      favsongListNotifier.notifyListeners();
      allSongListNotifier.notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('deleted from favlist..')));
    }
    count++;
  }
  allsongshowfavlist();
}

allsongshowfavlist() async {
  final addfavdb = await Hive.openBox<songsmodel>('favlistdb');
  favsongListNotifier.value.clear();
  favsongListNotifier.value.addAll(addfavdb.values);
  favsongListNotifier.notifyListeners();
}

Future<void> addrecentlyplayed(songsmodel data) async {
  final recentlyplayeddatabae =
      await Hive.openBox<songsmodel>("recentlyplayeddb");
  int count = 0;
  for (var elements in recentlyplayeddatabae.values) {
    count++;
  }
  if (count > 4) {
    recentlyplayeddatabae.deleteAt(0);
  }
  int index = 0;
  for (var element in recentlyplayeddatabae.values) {
    if (element.id == data.id) {
      recentlyplayeddatabae.deleteAt(index);
    }
    index++;
  }
  recentlyplayeddatabae.add(data);
  allrecentlyplaylistshow();
}

allrecentlyplaylistshow() async {
  final recentlyplayeddatabae =
      await Hive.openBox<songsmodel>("recentlyplayeddb");
  recentlyPlayedNotifier.value.clear();
  recentlyPlayedNotifier.value.addAll(recentlyplayeddatabae.values);
  recentlyPlayedNotifier.value =
      List<songsmodel>.from(recentlyPlayedNotifier.value.reversed);
  recentlyPlayedNotifier.notifyListeners();
}

void mostPlayedSongs(songsmodel data) async {
  final mostplayedDB = await Hive.openBox<songsmodel>('mostplayedDB');

  bool check = false;

  int count = 0;
  int index = 0;
  for (var element in mostplayedDB.values) {
    count++;
  }
  if (count > 10) {
    mostplayedDB.deleteAt(0);
  }
  for (var element in mostplayedDB.values) {
    if (data.id == element.id) {
      check = true;
      break;
    }
    index++;
  }
  if (check == true) {
    var value = mostplayedDB.getAt(index);
    print("the count of the song is ${value!.count}");
    int thisCount = value.count + 1;
    final newsong = songsmodel(
        songName: data.songName,
        artistName: data.songName,
        uri: data.uri,
        id: data.id,
        duration: data.duration,
        count: thisCount);
    mostplayedDB.putAt(index, newsong);
  } else {
    int mostplayedcount = 1;
    final newsong = songsmodel(
        songName: data.songName,
        artistName: data.songName,
        uri: data.uri,
        id: data.id,
        duration: data.duration,
        count: mostplayedcount);
    mostplayedDB.add(newsong);
  }

  allMostPlayedListShow();
}

void allMostPlayedListShow() async {
  final mostplayedDB = await Hive.openBox<songsmodel>('mostplayedDB');
  mostplayedsongNotifier.value.clear();
  for (var element in mostplayedDB.values) {
    print("the count of number songs that played ${element.count}");
    if (element.count >= 2) {
      mostplayedsongNotifier.value.add(element);
    }
  }
  print("object");
  for (int i = 0; i < mostplayedsongNotifier.value.length; i++) {
    for (int j = i + 1; j < mostplayedsongNotifier.value.length; j++) {
      if (mostplayedsongNotifier.value[i].count <
          mostplayedsongNotifier.value[j].count) {
        songsmodel temp = mostplayedsongNotifier.value[i];
        mostplayedsongNotifier.value[i] = mostplayedsongNotifier.value[j];
        mostplayedsongNotifier.value[j] = temp;
      }
    }
  }
  mostplayedsongNotifier.notifyListeners();
}
