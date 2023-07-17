import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ValueNotifier<int> currentindexnotifier = ValueNotifier(0);

class nav_bar extends StatelessWidget {
  const nav_bar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: currentindexnotifier,
      builder: (context, int index, child) {
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color(0xF61796FF),
            elevation: 0,
            onTap: (value) {
              currentindexnotifier.value = value;
            },
            currentIndex: index,
            fixedColor: Colors.white,
            items: const [
              BottomNavigationBarItem(
                label: 'All Songs',
                icon: Icon(Icons.list_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Search',
                icon: Icon(Icons.search_rounded),
              ),
              BottomNavigationBarItem(
                label: 'Library',
                icon: Icon(Icons.library_books),
              ),
            ]);
      },
    );
  }
}
