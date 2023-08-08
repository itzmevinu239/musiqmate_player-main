import 'package:flutter/material.dart';

import '../../db/functions/newdbf.dart';
import '../../db/model/songsmodel.dart';
import '../../notifirelist/songNotifierList.dart';
import '../all_widgets_screen/widgets.dart';

class Mostplayed extends StatefulWidget {
  const Mostplayed({super.key});

  @override
  State<Mostplayed> createState() => _MostplayedState();
}

class _MostplayedState extends State<Mostplayed> {
  @override
  Widget build(BuildContext context) {
    allMostPlayedListShow();
    return Container(
      height: MediaQuery.of(context).size.height * 1,
      width: MediaQuery.of(context).size.width * 1,
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
          title: const Text(
            'Most Played',
            style: TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
                fontSize: 25,
                fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: ValueListenableBuilder(
          valueListenable: mostplayedsongNotifier,
          builder: (
            BuildContext context,
            List<songsmodel> mostplayed,
            Widget? child,
          ) {
            return mostplayed.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: mostplayed.length,
                      itemBuilder: (BuildContext context, int index) {
                        final data = mostplayed[index];
                        return mostplayed.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(50, 255, 255, 255),
                                    borderRadius: BorderRadius.circular(8)),
                                margin: const EdgeInsets.only(bottom: 5),
                                child: Recentlyplayedandmostplayed(
                                    data: data,
                                    index: index,
                                    newlist: mostplayed))
                            : const Text("No songs");
                      },
                    ),
                  )
                : const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          "NO SONGS",
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.w500,
                              fontSize: 18),
                        ),
                      ),
                    ],
                  );
          },
        ),
      ),
    );
  }
}
