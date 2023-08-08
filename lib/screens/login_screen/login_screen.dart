import 'package:flutter/material.dart';
import 'package:musiq_player/controler/player_controller.dart';
import 'package:musiq_player/navbar/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final namectr = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchsongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8028DF), Color(0xFF3F9EFD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 120),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'FIND YOUR\nFAVORITE\nMUSIC',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 55,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 10.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'FIND YOUR LATEST FAVORITE MUSIC\nFROME OUR COLLECTION',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 20,
                  letterSpacing: .5,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Stack(children: [
                Container(
                  width: 370,
                  height: 370,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8028DF), Color(0xFF3F9EFD)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(7.5),
                  child: Container(
                    width: 355,
                    height: 355,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      image: const DecorationImage(
                          image: AssetImage('assets/Images/01.jpg'),
                          alignment: Alignment(-0.8, -0.5),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
              ]),
              const SizedBox(
                height: 8,
              ),
              TextButton(
                onPressed: () async {
                  final sharedpre = await SharedPreferences.getInstance();
                  sharedpre.setBool("check", true);
                  // ignore: use_build_context_synchronously
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => NavMainPage()));
                },
                child: Container(
                  width: 110,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF8028DF), Color(0xFF3F9EFD)],
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 12),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
