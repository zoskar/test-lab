import 'package:patrol/patrol.dart';
import 'pages/connection_pom.dart';
import 'pages/home_pom.dart';
import 'util/common.dart';

void main() {
  final automator = NativeAutomator2(config: nativeConfig);
  // TODO: fix for iOS
  patrolTearDown(() async {
    await automator.enableWifi();
    await automator.enableCellular();
  });

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
