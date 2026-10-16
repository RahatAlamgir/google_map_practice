import 'package:flutter/material.dart';
import 'package:google_map_practice/data/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapGestureScreen extends StatefulWidget {
  const MapGestureScreen({super.key});

  @override
  State<MapGestureScreen> createState() => _MapGestureScreenState();
}

class _MapGestureScreenState extends State<MapGestureScreen> {
  GoogleMapController? _map;

  bool _scroll = false;
  bool _zoom = false;
  bool _rotated = false;
  bool _tilt = false;

  ValueNotifier<CameraPosition> _camara = ValueNotifier<CameraPosition>(
    Places.openingCamera,
  );

  void resetPosition() {
    _map?.animateCamera(CameraUpdate.newCameraPosition(Places.openingCamera));
  }

  void zoomIn() {
    _map?.animateCamera(CameraUpdate.zoomIn());
  }

  void zoomOut() {
    _map?.animateCamera(CameraUpdate.zoomOut());
  }

  void goPlace() {
    _map?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Places.parliament.position,
          zoom: 18,
          bearing: 45,
          tilt: 50,
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _camara.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            ValueListenableBuilder<CameraPosition>(
              valueListenable: _camara,
              builder: (context, camara, child) {
                final LatLng target = camara.target;
                return Text(
                  'Lat:${target.latitude.toStringAsFixed(4)}, ${target.longitude.toStringAsFixed(4)}\n'
                  'Zoom: ${camara.zoom.toString()}\n'
                  'Tilt: ${camara.tilt.toString()}\n'
                  'Beargin: ${camara.bearing.toString()}\n',
                );
              },
            ),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: Places.openingCamera,
                scrollGesturesEnabled: _scroll,
                zoomGesturesEnabled: _zoom,
                rotateGesturesEnabled: _rotated,
                tiltGesturesEnabled: _tilt,
                onMapCreated: (GoogleMapController controller) {
                  _map = controller;
                },
                onCameraMove: (position) {
                  _camara.value = position;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                children: [
                  FilterChip(
                    label: Text("Scroll"),
                    selected: _scroll,
                    onSelected: (value) {
                      setState(() {
                        _scroll = value;
                      });
                    },
                  ),
                  FilterChip(
                    label: Text("Zoom"),
                    selected: _zoom,
                    onSelected: (value) {
                      setState(() {
                        _zoom = value;
                      });
                    },
                  ),
                  FilterChip(
                    label: Text("Rotated"),
                    selected: _rotated,
                    onSelected: (value) {
                      setState(() {
                        _rotated = value;
                      });
                    },
                  ),
                  FilterChip(
                    label: Text("Tilt"),
                    selected: _tilt,
                    onSelected: (value) {
                      setState(() {
                        _tilt = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      resetPosition();
                    },
                    child: Text("Reset"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      zoomIn();
                    },
                    child: Text("+"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      zoomOut();
                    },
                    child: Text("-"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      goPlace();
                    },
                    child: Text("GO"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
