import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class GPSPage extends StatefulWidget {
  const GPSPage({super.key});

  @override
  State<GPSPage> createState() => _GPSPageState();
}

class _GPSPageState extends State<GPSPage> {
  final Location _location = Location();
  final MapController _mapController = MapController();
  final List<Marker> _markers = [];

  // Default position (will be updated with the user's location)
  LatLng _currentPosition = const LatLng(0, 0);
  bool _locationObtained = false;
  bool _mapReady = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    // Check if location services are enabled
    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Check if location permission is granted
    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Get location
    locationData = await _location.getLocation();

    // Update map position
    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    setState(() {
      _currentPosition = latLng;

      // Add marker for user location
      _markers
        ..clear()
        ..add(
          Marker(
            point: latLng,
            width: 80,
            height: 80,
            child: const Icon(Icons.location_on, color: Colors.red, size: 40),
          ),
        );

      _locationObtained = true;
    });

    // Move map to user location only if map is ready
    if (_mapReady) {
      _mapController.move(_currentPosition, 15);
    }

    // Subscribe to location changes
    _location.onLocationChanged.listen((currentLocation) {
      final latLng = LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );

      setState(() {
        _currentPosition = latLng;
        _markers
          ..clear()
          ..add(
            Marker(
              point: latLng,
              width: 80,
              height: 80,
              child: const Icon(Icons.location_on, color: Colors.red, size: 40),
            ),
          );
      });

      // Only move the map if it's ready
      if (_mapReady) {
        _mapController.move(_currentPosition, _mapController.camera.zoom);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS Map')),
      body:
          _locationObtained
              ? FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  initialCenter: _currentPosition,
                  initialZoom: 15,
                  minZoom: 3,
                  maxZoom: 18,
                  onMapReady: () {
                    setState(() {
                      _mapReady = true;
                      // Now it's safe to move the map
                      _mapController.move(_currentPosition, 15);
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    userAgentPackageName: 'com.example.app',
                  ),
                  MarkerLayer(markers: _markers),
                  RichAttributionWidget(
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              )
              : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final locationData = await _location.getLocation();
          final latLng = LatLng(
            locationData.latitude!,
            locationData.longitude!,
          );

          setState(() {
            _currentPosition = latLng;
            _markers
              ..clear()
              ..add(
                Marker(
                  point: latLng,
                  width: 80,
                  height: 80,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                ),
              );
          });

          // Only move the map if it's ready
          if (_mapReady) {
            _mapController.move(_currentPosition, 15);
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
