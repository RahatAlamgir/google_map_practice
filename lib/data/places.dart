import 'package:google_maps_flutter/google_maps_flutter.dart';

class Landmark {
  final String id;
  final String name;
  final LatLng position;
  final String fact;
  const Landmark({
    required this.id,
    required this.name,
    required this.position,
    required this.fact,
  });
}

class Places {
  static const Landmark shahimMinar = Landmark(
    id: "shahid_minar",
    name: "Shahid Minar",
    position: LatLng(23.7271, 90.3967),
    fact: 'Remembers the Language Movement',
  );

  static const List<Landmark> all = [shahimMinar];

  static const CameraPosition openingCamera = CameraPosition(
    target: LatLng(23.7271, 90.3967),
    zoom: 12,
  );
}
