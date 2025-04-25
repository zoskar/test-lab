import 'package:flutter/foundation.dart';
import 'package:patrol/patrol.dart';
import 'pages/connection_pom.dart';
import 'pages/home_pom.dart';
import 'util/common.dart';

void main() {
  final automator = NativeAutomator(config: nativeConfig);

  if (defaultTargetPlatform == TargetPlatform.android) {
    patrolTearDown(() async {
      await automator.enableWifi();
      await automator.enableCellular();
    });
  }

  patrolTest('tests connection status page', ($) async {
    final homePage = HomePageObject($);
    final connectionPage = ConnectionPageObject($);

    await Common.openApp($);
    await automator.disableWifi();
    await automator.disableCellular();
    await homePage.openConnection();
    await connectionPage.checkIfDisconnected();
    await automator.enableWifi();
    await automator.enableCellular();
    await connectionPage.checkIfConnected();
  });
}
