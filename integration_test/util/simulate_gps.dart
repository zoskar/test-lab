import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gpx/gpx.dart';
import 'package:patrol/patrol.dart';

Future<void> playGpxTrack(PatrolIntegrationTester $) async {
  final waypoints = await loadGpxWaypoints($);
  final startWaypoint = waypoints[0];
  DateTime? previousTime;
  await $.native2.setMockLocation(startWaypoint.lat!, startWaypoint.lon!);

  for (var i = 1; i < waypoints.length; i++) {
    final waypoint = waypoints[i];
    if (previousTime != null) {
      await Future<void>.delayed(const Duration(milliseconds: 500));
    }
    previousTime = waypoint.time;
    await $.native2.setMockLocation(waypoint.lat!, waypoint.lon!);
  }
}

Future<List<Wpt>> loadGpxWaypoints(PatrolIntegrationTester $) async {
  final gpxString = await rootBundle.loadString('assets/locations.gpx');
  final gpx = GpxReader().fromString(gpxString);
  return gpx.wpts;
}
