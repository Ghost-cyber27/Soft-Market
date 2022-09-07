import 'package:flutter/material.dart';
import 'package:soft_market/screens/components/body.dart';
import 'package:soft_market/splash_screen.dart';
import 'about.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: newMethod(),
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white),
          child: ListView(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
                child: Container(
                  alignment: Alignment.bottomLeft,
                  child: const Text(
                    "Navigation side bar",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(
                  Icons.book,
                  size: 24,
                  color: Colors.black,
                ),
                title: const Text(
                  "About Us",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const About()));
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ListTile(
                leading: const Icon(
                  Icons.screen_lock_landscape_rounded,
                  size: 24,
                  color: Colors.black,
                ),
                title: const Text(
                  "Log Out",
                  style: TextStyle(fontSize: 17, color: Colors.black),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Splash()));
                },
              ),
            ],
          ),
        ),
      ),
      body: const Body(),
    );
  }

  AppBar newMethod() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      //add the icons here
    );
  }
}
