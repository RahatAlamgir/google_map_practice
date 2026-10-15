import 'package:flutter/material.dart';
import 'package:google_map_practice/screens/map1.dart';
import 'package:google_map_practice/screens/map2.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Deshboard")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Map1Screen()),
                );
              },
              child: Text("Map 1"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MapGestureScreen()),
                );
              },
              child: Text("Map 2"),
            ),
          ],
        ),
      ),
    );
  }
}
