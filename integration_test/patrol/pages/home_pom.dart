import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class HomePageObject {
  HomePageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> openLogin() async {
    await $(keys.homePage.loginTile).tap();
  }

  Future<void> openNotifications() async {
    await $(
      keys.homePage.notificationsTile,
    ).tap(settlePolicy: SettlePolicy.noSettle);
  }

  Future<void> openQrScanner() async {
    await $(keys.homePage.qrTile).tap();
  }

  Future<void> openWebView() async {
    await $(keys.homePage.webViewTile).tap();
  }

  Future<void> openGps() async {
    await $(keys.homePage.gpsTile).tap(settlePolicy: SettlePolicy.noSettle);
  }

  Future<void> openConnection() async {
    await $(keys.homePage.connectionTile).tap();
  }

  Future<void> openForm() async {
    await $(keys.homePage.formTile).tap();
  }
}
