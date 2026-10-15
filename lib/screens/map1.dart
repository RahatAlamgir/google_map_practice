import 'package:flutter/material.dart';
import 'package:google_map_practice/data/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map1Screen extends StatefulWidget {
  const Map1Screen({super.key});

  @override
  State<Map1Screen> createState() => _Map1ScreenState();
}

class _Map1ScreenState extends State<Map1Screen> {
  String markName = "";
  String latlan = "";
  Set<Marker> _markers() {
    return {
      for (final Landmark place in Places.all)
        Marker(
          markerId: MarkerId(place.id),
          position: place.position,
          onTap: () {
            setState(() {
              markName = place.name;
            });
          },
          infoWindow: InfoWindow(
            title: place.name,
            snippet: place.fact,
            onTap: () {
              setState(() {
                latlan = place.position.toString();
              });
            },
          ),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map1")),
      body: Center(
        child: Column(
          children: [
            Text(markName),
            Text(latlan),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: Places.openingCamera,

                zoomGesturesEnabled: false,

                markers: _markers(),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
