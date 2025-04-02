import 'dart:async';
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
  StreamSubscription<LocationData>? _locationSubscription;

  // Default position (will be updated with the user's location)
  LatLng _currentPosition = const LatLng(0, 0);
  bool _locationObtained = false;
  bool _mapReady = false;

  // Waypoint coordinates
  final LatLng _waypointPosition = const LatLng(
    52.212771677342275,
    20.97159515378119,
  );
  final double _proximityThreshold = 50; // meters
  bool _reachedWaypoint = false;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  @override
  void dispose() {
    _cancelLocationSubscription(); // Cancel subscription when widget disposes
    _mapController.dispose();
    super.dispose();
  }

  // Add method to cancel location subscription
  void _cancelLocationSubscription() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  // Calculate distance between two points in meters
  double _calculateDistance(LatLng point1, LatLng point2) {
    const distance = Distance();
    return distance.as(LengthUnit.Meter, point1, point2);
  }

  void _checkProximityToWaypoint(LatLng position) {
    final double distance = _calculateDistance(position, _waypointPosition);

    if (distance <= _proximityThreshold && !_reachedWaypoint) {
      setState(() {
        _reachedWaypoint = true;
      });
      _showSuccessDialog();
    }
  }

  void _showSuccessDialog() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Success!'),
          content: const Text('You have reached the waypoint!'),
          backgroundColor: Colors.green[100],
          actions: <Widget>[
            TextButton(
              child: const Text('Continue'),
              onPressed: () {
                _cancelLocationSubscription();
                Navigator.of(context).popUntil(ModalRoute.withName('/'));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await _location.getLocation();

    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    setState(() {
      _currentPosition = latLng;

      // Add marker for user location
      _markers
        ..clear()
        ..add(
          Marker(
            point: latLng,
            width: 40,
            height: 40,
            child: const Icon(
              Icons.person_pin_circle,
              color: Colors.blue,
              size: 30,
            ),
          ),
        )
        ..add(
          Marker(
            point: _waypointPosition,
            width: 40,
            height: 40,
            child: const Icon(Icons.location_on, color: Colors.red, size: 30),
          ),
        );

      _locationObtained = true;
    });

    _checkProximityToWaypoint(latLng);

    // Move map to user location only if map is ready
    if (_mapReady) {
      _mapController.move(_currentPosition, 15);
    }

    // Subscribe to location changes
    _locationSubscription = _location.onLocationChanged.listen((
      currentLocation,
    ) {
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
              width: 40,
              height: 40,
              child: const Icon(
                Icons.person_pin_circle,
                color: Colors.blue,
                size: 30,
              ),
            ),
          )
          ..add(
            Marker(
              point: _waypointPosition,
              width: 40,
              height: 40,
              child: const Icon(Icons.location_on, color: Colors.red, size: 30),
            ),
          );
      });

      _checkProximityToWaypoint(latLng);

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
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.person_pin_circle,
                    color: Colors.blue,
                    size: 30,
                  ),
                ),
              )
              ..add(
                Marker(
                  point: _waypointPosition,
                  width: 40,
                  height: 40,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 30,
                  ),
                ),
              );
          });

          _checkProximityToWaypoint(latLng);

          if (_mapReady) {
            _mapController.move(_currentPosition, 15);
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
