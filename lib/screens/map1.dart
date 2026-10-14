import 'package:flutter/material.dart';
import 'package:google_map_practice/data/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map1Screen extends StatefulWidget {
  const Map1Screen({super.key});

  @override
  State<Map1Screen> createState() => _Map1ScreenState();
}

class _Map1ScreenState extends State<Map1Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map1")),
      body: Center(
        child: GoogleMap(
          initialCameraPosition: Places.openingCamera,
          zoomControlsEnabled: false,
          markers: {
            Marker(
              markerId: MarkerId("test marker"),
              position: Places.all.first.position,
            ),
          },
        ),
      ),
    );
  }
}
