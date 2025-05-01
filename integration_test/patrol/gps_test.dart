import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

import '../util/common.dart';
import '../util/simulate_gps.dart';
import 'pages/gps_page.dart';
import 'pages/home_pom.dart';

void main() {
  patrolTest(
    framePolicy: LiveTestWidgetsFlutterBindingFramePolicy.fullyLive,
    'tests GPS tracking',
    ($) async {
      final homePage = HomePageObject($);
      final gpsPageObject = GpsPageObject($);

      await Common.openApp($);
      await homePage.openGps();
      await $.native2.grantPermissionOnlyThisTime();
      await playGpxTrack($);
      await gpsPageObject.isSuccessDialogVisible();
    },
  );
}
