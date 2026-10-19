import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:google_map_practice/data/places.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends StatefulWidget {
  const CustomMarker({super.key});

  @override
  State<CustomMarker> createState() => _CustomMarkerState();
}

class _CustomMarkerState extends State<CustomMarker> {
  BitmapDescriptor? _campusPin;
  //Timer? _pulseTimer;
  //double _pulseScale = 1.0;
  //bool _growing = true;

  // Future<BitmapDescriptor> _getCircularBitmapFromAsset(
  //   String path,
  //   int size,
  // ) async {
  //   // 1. Load image bytes from assets
  //   ByteData data = await rootBundle.load(path);
  //   ui.Codec codec = await ui.instantiateImageCodec(
  //     data.buffer.asUint8List(),
  //     targetWidth: size,
  //     targetHeight: size,
  //   );
  //   ui.FrameInfo fi = await codec.getNextFrame();
  //   ui.Image image = fi.image;

  //   // 2. Set up picture recorder and canvas
  //   final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  //   final Canvas canvas = Canvas(pictureRecorder);
  //   final Paint paint = Paint()..isAntiAlias = true;

  //   final double radius = size / 2.0;
  //   final Offset center = Offset(radius, radius);

  //   // 3. Clip canvas to a circle
  //   canvas.clipPath(
  //     Path()..addOval(Rect.fromCircle(center: center, radius: radius)),
  //   );

  //   // 4. Draw the image onto the circular canvas
  //   canvas.drawImage(image, Offset.zero, paint);

  //   // Optional: Add a white border ring around the circle
  //   final Paint borderPaint = Paint()
  //     ..color = Colors.green
  //     ..style = PaintingStyle.stroke
  //     ..strokeWidth = 4.0;
  //   canvas.drawCircle(center, radius - 2, borderPaint);

  //   // 5. Convert canvas to image bytes
  //   final ui.Image finalImage = await pictureRecorder.endRecording().toImage(
  //     size,
  //     size,
  //   );
  //   final ByteData? byteData = await finalImage.toByteData(
  //     format: ui.ImageByteFormat.png,
  //   );
  //   final Uint8List uint8List = byteData!.buffer.asUint8List();

  //   return BitmapDescriptor.fromBytes(uint8List);
  // }

  Future<BitmapDescriptor> _getCustomPinFromAsset(String path, int size) async {
    // 1. Load image bytes from assets
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: size,
      targetHeight: size,
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    ui.Image image = fi.image;

    // 2. Set dimensions for a teardrop pin shape
    final double width = size.toDouble();
    final double height = size * 1.3; // Extra space for the pin tip
    final double radius = width / 2.0;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // 3. Draw the Pin Background (Teardrop shape)
    final Path pinPath = Path()
      ..addOval(Rect.fromCircle(center: Offset(radius, radius), radius: radius))
      ..moveTo(radius * 0.3, radius * 1.7)
      ..lineTo(radius, height)
      ..lineTo(radius * 1.7, radius * 1.7)
      ..close();

    // Draw shadow/border for the pin background
    final Paint backgroundPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = Colors
          .blueAccent // Border color of your pin
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // Draw pin background & border
    canvas.drawPath(pinPath, backgroundPaint);
    canvas.drawPath(pinPath, borderPaint);

    // 4. Clip and draw the image inside the circular head of the pin
    canvas.save();
    Path clipPath = Path()
      ..addOval(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius - 3),
      );
    canvas.clipPath(clipPath);

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(3, 3, width - 6, width - 6),
      Paint(),
    );
    canvas.restore();

    // 5. Convert canvas to image bytes
    final ui.Image finalImage = await pictureRecorder.endRecording().toImage(
      width.toInt(),
      height.toInt(),
    );
    final ByteData? byteData = await finalImage.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.fromBytes(uint8List);
  }

  Future<void> _loadCampusPin() async {
    // _campusPin = await BitmapDescriptor.asset(
    //   ImageConfiguration(size: Size(24, 24)),
    //   "assets/panda.jpg",
    // );

    _campusPin = await _getCustomPinFromAsset("assets/panda.jpg", 100);
    if (mounted) {
      setState(() {});
    }
  }

  Marker _huePin(Landmark place, double hue) {
    return Marker(
      markerId: MarkerId(place.id),
      position: place.position,
      infoWindow: InfoWindow(title: place.name, snippet: place.fact),
      icon: BitmapDescriptor.defaultMarkerWithHue(hue),
    );
  }

  Set<Marker> _markers() {
    return {
      _huePin(Places.hatirjheel, BitmapDescriptor.hueBlue),
      _huePin(Places.parliament, BitmapDescriptor.hueGreen),
      Marker(
        markerId: MarkerId(Places.university.id),
        position: Places.university.position,
        icon: _campusPin ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(
          title: Places.university.name,
          snippet: _campusPin == null ? "adding" : "draw done",
        ),
      ),
    };
  }

  // void _startPulsingPin() {
  //   // Base size of your pin (e.g., 100 pixels wide)
  //   const int baseSize = 100;
  //   // Min and Max scale factors for the pulse effect
  //   const double minScale = 0.95;
  //   const double maxScale = 1.05;

  //   // Run timer every 100ms (~10 FPS is smooth enough for marker pulsing and saves CPU)
  //   _pulseTimer = Timer.periodic(const Duration(milliseconds: 100), (
  //     timer,
  //   ) async {
  //     if (!mounted) {
  //       timer.cancel();
  //       return;
  //     }

  //     // Adjust scale direction
  //     if (_growing) {
  //       _pulseScale += 0.01;
  //       if (_pulseScale >= maxScale) _growing = false;
  //     } else {
  //       _pulseScale -= 0.01;
  //       if (_pulseScale <= minScale) _growing = true;
  //     }

  //     // Calculate dynamic size based on current scale
  //     int currentSize = (baseSize * _pulseScale).toInt();

  //     // Generate the custom pin at the new size
  //     BitmapDescriptor updatedPin = await _getCustomPinFromAsset(
  //       "assets/panda.jpg",
  //       currentSize,
  //     );

  //     if (mounted) {
  //       setState(() {
  //         _campusPin = updatedPin;
  //       });
  //     }
  //   });
  // }

  @override
  void initState() {
    _loadCampusPin();

    super.initState();
    //_startPulsingPin();
  }

  @override
  void dispose() {
    //_pulseTimer?.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Custom Marker")),
      body: Center(
        child: Column(
          children: [
            Text("Custom Marker"),
            Expanded(
              child: GoogleMap(
                initialCameraPosition: Places.openingCamera,
                zoomControlsEnabled: true,
                markers: _markers(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
