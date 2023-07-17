import '../db/model/playlistmodel.dart';
import '../db/model/songsmodel.dart';
import 'package:flutter/material.dart';

ValueNotifier<List<songsmodel>> allSongListNotifier = ValueNotifier([]);

ValueNotifier<List<songsmodel>> favsongListNotifier = ValueNotifier([]);

ValueNotifier<List<songsmodel>> recentlyPlayedNotifier = ValueNotifier([]);

ValueNotifier<List<songsmodel>> mostplayedsongNotifier = ValueNotifier([]);

ValueNotifier<List<songsmodel>> playlistsongnotifier = ValueNotifier([]);

ValueNotifier<List<playlistmodel>> playlistnamenotifier = ValueNotifier([]);

ValueNotifier<bool> isSongPlayingNotifier = ValueNotifier(false);

ValueNotifier<bool> isadded = ValueNotifier(true);
