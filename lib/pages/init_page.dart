import 'package:flutter/material.dart';
import 'package:flutter_codigo5_youapp/pages/home_page.dart';
import 'package:flutter_codigo5_youapp/ui/general/colors.dart';

class InitPage extends StatefulWidget {
  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  int currentPage = 0;

  List<Widget> _pages = [
    HomePage(),
    Center(child: Text("Page 2"),),
    Center(child: Text("Page 3"),),
    Center(child: Text("Page 4"),),
    Center(child: Text("Page 5"),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBrandPrimaryColor,
        title: Image.asset(
          'assets/images/logo.png',
          height: 26.0,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.cast,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.notifications_none,
                ),
                Positioned(
                  top: -2,
                  right: -4,
                  child: Container(
                    padding: const EdgeInsets.all(2.4),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: const Text(
                      "9+",
                      style: TextStyle(
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
            ),
          ),
          const SizedBox(
            width: 8.0,
          ),
          CircleAvatar(
            radius: 20.0,
            backgroundColor: Colors.white24,
            backgroundImage: AssetImage("assets/images/fmogollon.jpg"),

          ),
          const SizedBox(
            width: 14.0,
          ),
        ],
      ),
      body: _pages[currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: kBrandPrimaryColor,
        selectedFontSize: 12.0,
        unselectedItemColor: Colors.white70,
        unselectedFontSize: 12.0,
        selectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap: (int value) {
          currentPage = value;
          setState(() {
          });
        },
        items: [
          const BottomNavigationBarItem(
            label: "Principal",
            icon: Icon(
              Icons.home_filled,
            ),
          ),
          const BottomNavigationBarItem(
            label: "Shorts",
            icon: Icon(
              Icons.play_arrow_rounded,
            ),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Container(
              margin: const EdgeInsets.only(top: 4.0),
              child: const Icon(
                Icons.add_circle_outline,
                size: 30.0,
              ),
            ),
          ),
          const BottomNavigationBarItem(
            label: "Suscripciones",
            icon: Icon(
              Icons.subscriptions_outlined,
            ),
          ),
          const BottomNavigationBarItem(
            label: "Biblioteca",
            icon: Icon(
              Icons.video_collection_outlined,
            ),
          ),
        ],
      ),
    );
  }
}
