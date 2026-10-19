import 'package:flutter/material.dart';
import 'package:google_map_practice/screens/custom_marker.dart';
import 'package:google_map_practice/screens/gps_screen.dart';
import 'package:google_map_practice/screens/map1.dart';
import 'package:google_map_practice/screens/map_gesture_screen.dart';
import 'package:google_map_practice/screens/permission_screen.dart';
import 'package:google_map_practice/screens/polyline.dart';

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
              child: Text("Map Gesture"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => GpsScreen()),
                );
              },
              child: Text("Map GPS"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PermissionScreen()),
                );
              },
              child: Text("Permissions"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PolylinesScreen()),
                );
              },
              child: Text("Polyline"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CustomMarker()),
                );
              },
              child: Text("Custom Marker"),
            ),
          ],
        ),
      ),
    );
  }
}
