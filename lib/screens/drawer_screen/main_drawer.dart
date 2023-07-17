import 'dart:io';

import 'package:flutter/material.dart';
import 'package:musiq_player/screens/dialog_screen/privacy_policy.dart';
import 'package:musiq_player/screens/dialog_screen/terms_condition.dart';

class main_drawer extends StatelessWidget {
  const main_drawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFF3F9EFD),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width * 1,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8028DF), Color(0xFF3F9EFD)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(top: 50, bottom: 20),
                    child: Image.asset('assets/Images/Logo.png'),
                  ),
                  const Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 25, letterSpacing: 1, color: Colors.white),
                  ),
                  const Divider(
                    thickness: 1.5,
                    color: Color.fromARGB(53, 173, 218, 255),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.privacy_tip,
                      color: Colors.white,
                      size: 25,
                    ),
                    title: GestureDetector(
                      child: const Text(
                        'Privacy Policy',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return privacydialoge(
                                  mdFileName: 'Privacy_policy.md');
                            });
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.view_list,
                      color: Colors.white,
                      size: 25,
                    ),
                    title: GestureDetector(
                      child: const Text(
                        'About Us',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationIcon: Image.asset(
                            "assets/Images/Logo.png",
                            height: 50,
                            width: 60,
                          ),
                          applicationName: "MusiqMate",
                          applicationVersion: "1.0.1",
                          children: [
                            const Text(
                                "MusiqMate is an offline Music player app which allows use "
                                "to Play Audio files from their local storage and also do"
                                " functions like add to favorites , create playlists , recently played etc."),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("App developed by Vinu Raju.")
                          ],
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.sticky_note_2,
                      color: Colors.white,
                      size: 25,
                    ),
                    title: GestureDetector(
                      child: const Text(
                        'Terms And Conditions',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Terms_condition(
                                  mdFileName1: 'Terms_And_Condition.md');
                            });
                      },
                    ),
                  ),
                  GestureDetector(
                    child: const ListTile(
                      leading: Icon(
                        Icons.exit_to_app_outlined,
                        color: Colors.white,
                        size: 25,
                      ),
                      title: Text(
                        'Quit',
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
                    onTap: () => exit(0),
                  ),
                  const SizedBox(
                    height: 160.7,
                  ),
                  const Text(
                    'Version',
                    style: TextStyle(fontSize: 12),
                  ),
                  const Text(
                    '1.0.0',
                    style: TextStyle(fontSize: 10),
                  ),
                  const SizedBox(
                    height: 25,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
