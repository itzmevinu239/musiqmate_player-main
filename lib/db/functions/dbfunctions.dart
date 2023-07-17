import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:musiq_player/db/model/songsmodel.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../notifirelist/songNotifierList.dart';
import '../model/playlistmodel.dart';

void allsongsAdddb(SongModel data) async {
  final allsongdb = await Hive.openBox<songsmodel>('boxname');

  final newsongs = songsmodel(
      songName: data.displayName,
      artistName: data.artist!,
      uri: data.uri!,
      id: data.id,
      duration: data.duration!);

  bool flag = true;

  for (var element in allsongdb.values) {
    if (element.id == newsongs.id) {
      flag = false;
    }
  }
  if (flag == true) {
    allsongdb.add(newsongs);
  }
}

allsongsdatashowList() async {
  final allsongsdb = await Hive.openBox<songsmodel>('boxname');
  allSongListNotifier.value.clear();
  allSongListNotifier.value.addAll(allsongsdb.values);
  allSongListNotifier.notifyListeners();
}

addplaylistdbtovaluelistenable() async {
  final playlistDB = await Hive.openBox<playlistmodel>('playlistDB');
  playlistnamenotifier.value.clear();
  playlistnamenotifier.value.addAll(playlistDB.values);
  playlistnamenotifier.notifyListeners();
}

addplaylisttodatabase(
    String listname, List<songsmodel> listarray, context) async {
  final playlistDB = await Hive.openBox<playlistmodel>('playlistDB');
  bool flag = true;
  for (var element in playlistDB.values) {
    if (listname == element.playlistname) {
      flag = false;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Already added'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  if (flag == true) {
    final newplaylsit =
        playlistmodel(playlistname: listname, playlistarray: listarray);
    playlistDB.add(newplaylsit);
    addplaylistdbtovaluelistenable();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Playlist Created'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

bool checkplaylist(songsmodel data) {
  for (var element in playlistsongnotifier.value) {
    if (data.id == element.id) {
      return true;
    }
  }
  return false;
}

bool favouritecheckings(songsmodel data) {
  for (var elements in favsongListNotifier.value) {
    if (data.id == elements.id) {
      return true;
    }
  }
  return false;
}

addtofavrourite(songsmodel data,context) async {
  final favouritedatabase = await Hive.openBox<songsmodel>("favlistDB");
  bool check = false;
  for (var elements in favouritedatabase.values) {
    if (data.id == elements.id) {
      check = true;
    }
  }
  if (check == false) {
    favouritedatabase.add(data);
    favsongListNotifier.notifyListeners();
    allSongListNotifier.notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Added to fav list"),
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 1),
    ));
  }
  allsongsfavlistshow();
}

allsongsfavlistshow() async {
  final favrioutedatabase = await Hive.openBox<songsmodel>("favlistDB");
  favsongListNotifier.value.clear();
  favsongListNotifier.value.addAll(favrioutedatabase.values);
  favsongListNotifier.notifyListeners();
}
//delete songs frome favorite list.....

deletefevsong(songsmodel data, context) async {
  final favdatabase = await Hive.openBox<songsmodel>('favlistDB');
  int count = 0;
  for (var element in favdatabase.values) {
    if (data.id == element.id) {
      favdatabase.deleteAt(count);
      favsongListNotifier.notifyListeners();
      allSongListNotifier.notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('deleted'),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ));
    }
    count++;
  }
  allsongsfavlistshow();
}

// songs add to playlist...
songaddtoplaylistdatabase(String listname, songsmodel songdata, context) async {
  final playlistDB = await Hive.openBox<playlistmodel>('playlistDB');
  int index = 0;
  List<songsmodel> newplayarray = [];
  bool flag = true;
  for (var element in playlistDB.values) {
    if (listname == element.playlistname) {
      newplayarray = element.playlistarray;
      for (var element in newplayarray) {
        if (songdata.id == element.id) {
          flag = false;
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Already added'),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 1)));
          return;
        }
      }
      if (flag == true) {
        newplayarray.add(songdata);
        final newplaylist =
            playlistmodel(playlistname: listname, playlistarray: newplayarray);
        playlistDB.putAt(index, newplaylist);
        playlistnamenotifier.notifyListeners();
        playlistsongnotifier.notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Added to Playlist'),
          behavior: SnackBarBehavior.floating,
          duration: Duration(seconds: 1),
        ));
      }
    }
    index++;
  }
}

playlistdelete(playlistmodel data, context) async {
  final playlistDB = await Hive.openBox<playlistmodel>('playlistDB');
  int count = 0;
  for (var element in playlistDB.values) {
    if (element.playlistname == data.playlistname) {
      playlistDB.deleteAt(count);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Deleted Play List"),
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 1),
      ));
    }
    count++;
  }
  addplaylistdbtovaluelistenable();
}

void playlistrename(String listname, List<songsmodel> listarray,
    context, int index) async {
  final playlistdb = await Hive.openBox<playlistmodel>("playlistDB");
  bool value = true;
  for (var elements in playlistdb.values) {
    if (listname == elements.playlistname) {
      value = false;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("The name is already in list"),
        behavior: SnackBarBehavior.floating,
      ));
    }
  }
  if (value == true) {
    final newplaylist =
        playlistmodel(playlistname: listname, playlistarray: listarray);
    playlistdb.putAt(index, newplaylist);
    addplaylistdbtovaluelistenable();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Plsylist updated"),
      behavior: SnackBarBehavior.floating,
    ));
  }
}

songsdeletefromplaylist(songsmodel data, String name) async {
  final playlistDB = await Hive.openBox<playlistmodel>('playlistDB');
  int index = 0;
  List<songsmodel> newlist;
  for (var element in playlistDB.values) {
    if (name == element.playlistname) {
      for (var elements in element.playlistarray) {
        if (data.id == elements.id) {
          element.playlistarray.remove(elements);
          newlist = element.playlistarray;
          final newplaylist =
              playlistmodel(playlistname: name, playlistarray: newlist);
          playlistDB.putAt(index, newplaylist);
          playlistsongnotifier.notifyListeners();
          playlistsongnotifier.notifyListeners();
          break;
        }
      }
    }
    index++;
  }
}
