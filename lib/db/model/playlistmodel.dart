import 'package:hive_flutter/adapters.dart';
import 'package:musiq_player/db/model/songsmodel.dart';
 part 'playlistmodel.g.dart';

@HiveType(typeId: 1)
class playlistmodel {
  @HiveField(0)
  String playlistname;
  @HiveField(1)
  List<songsmodel> playlistarray;

  playlistmodel({required this.playlistname, required this.playlistarray});
}
