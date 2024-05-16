// ignore_for_file: use_build_context_synchronously

import 'package:assignment/views/Liked.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StoreMap extends StatefulWidget {
  const StoreMap({super.key});

  @override
  State<StoreMap> createState() => _StoreMapState();
}

class _StoreMapState extends State<StoreMap> {
  double dist = 0.0;

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  final CameraPosition _initialCameraPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 11.0,
  );
  final Set<Marker> _markers = {};
  Marker? _targetMarker;

  void _setTargetMarker(double lat, double lon) {
    setState(() {
      _targetMarker = Marker(
        markerId: const MarkerId('target'),
        position: LatLng(lat, lon),
        icon: BitmapDescriptor.defaultMarker,
      );
      _markers.add(_targetMarker!);
    });
  }

  void showMessage(BuildContext context, double message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$message"),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Access provider data on initialization
    _setTargetMarker(storeData.lat, storeData.lon);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location and Distance'),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _initialCameraPosition,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {},
            markers: _markers,
          ),
          Positioned(
            bottom: 20.0,
            left: 20.0,
            child: FloatingActionButton(
              onPressed: () async {
                Position position = await determinePosition();
                double distanceInMeters = Geolocator.distanceBetween(
                  position.latitude,
                  position.longitude,
                  storeData.lat,
                  storeData.lon,
                );
                showMessage(context, distanceInMeters);
              },
              child: const Icon(Icons.directions),
            ),
          ),
        ],
      ),
    );
  }
}
