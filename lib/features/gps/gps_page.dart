import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

// TODO refactor this page

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
  final LatLng _waypointPosition = const LatLng(51.247619, 22.566694);
  final double _proximityThreshold = 15; // meters
  bool _reachedWaypoint = false;

  @override
  void initState() {
    super.initState();
    _initLocationServices();
  }

  @override
  void dispose() {
    _cancelLocationSubscription();
    _mapController.dispose();
    super.dispose();
  }

  // Cancel location subscription
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

  Marker _createUserMarker(LatLng position) {
    return Marker(
      point: position,
      width: 40,
      height: 40,
      child: const Icon(Icons.person_pin_circle, color: Colors.blue, size: 30),
    );
  }

  Marker _createWaypointMarker() {
    return Marker(
      point: _waypointPosition,
      width: 40,
      height: 40,
      child: const Icon(Icons.location_on, color: Colors.red, size: 30),
    );
  }

  void _updateMarkers(LatLng userPosition) {
    _markers
      ..clear()
      ..add(_createUserMarker(userPosition))
      ..add(_createWaypointMarker());
  }

  // Show success dialog when waypoint is reached
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

  // Initialize location services, request permissions, and begin tracking
  Future<void> _initLocationServices() async {
    // Request location service
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    // Request location permissions
    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    // Configure location settings
    await _location.changeSettings(
      interval: 500,
      distanceFilter: 5, // Minimum distance (meters) before updates
    );

    // Get initial location
    try {
      final locationData = await _location.getLocation();
      _updateLocationData(locationData);

      // Subscribe to location changes
      _locationSubscription = _location.onLocationChanged.listen(
        _updateLocationData,
        onError: (Object error) => debugPrint('Location error: $error'),
      );
    } catch (err) {
      debugPrint('Error initializing location: $err');
    }
  }

  // Handle location updates from any source
  void _updateLocationData(LocationData locationData) {
    if (!mounted) {
      return;
    }

    final latLng = LatLng(locationData.latitude!, locationData.longitude!);

    setState(() {
      _currentPosition = latLng;
      _updateMarkers(latLng);
      _locationObtained = true;
    });

    _checkProximityToWaypoint(latLng);

    // Move map to user location if map is ready
    if (_mapReady) {
      _mapController.move(_currentPosition, _mapController.camera.zoom);
    }
  }

  // Center the map on current position
  Future<void> _centerOnUserLocation() async {
    try {
      final locationData = await _location.getLocation();
      _updateLocationData(locationData);

      // Set zoom level to 15 when centering
      if (_mapReady) {
        _mapController.move(_currentPosition, 15);
      }
    } catch (err) {
      debugPrint('Error centering location: $err');
    }
  }

  // Build the map widget
  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _currentPosition,
        initialZoom: 17,
        minZoom: 17,
        maxZoom: 17,
        onMapReady: () {
          setState(() {
            _mapReady = true;
            _mapController.move(_currentPosition, 15);
          });
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.app',
        ),
        MarkerLayer(markers: _markers),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors', onTap: () {}),
          ],
        ),
      ],
    );
  }

  // Build distance indicator overlay
  Widget _buildDistanceIndicator() {
    if (!_locationObtained) {
      return const SizedBox.shrink();
    }

    final distance = _calculateDistance(_currentPosition, _waypointPosition);

    return Positioned(
      top: 16,
      left: 16,
      right: 16,
      child: Card(
        color: Colors.white.withValues(),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            'Distance to waypoint: ${distance.toStringAsFixed(1)} meters',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS Map')),
      body: Stack(
        children: [
          // Show loading indicator or map
          if (_locationObtained)
            _buildMap()
          else
            const Center(child: CircularProgressIndicator()),

          // Show distance indicator when location is obtained
          _buildDistanceIndicator(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _centerOnUserLocation,
        tooltip: 'Center on my location',
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
