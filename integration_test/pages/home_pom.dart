import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class HomePageObject {
  HomePageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> openLogin() async {
    await $(HomePageKeys.loginTile).tap();
  }

  Future<void> openNotifications() async {
    await $(
      HomePageKeys.notificationsTile,
    ).tap(settlePolicy: SettlePolicy.noSettle);
  }

  Future<void> openQrScanner() async {
    await $(HomePageKeys.qrTile).tap();
  }

  Future<void> openWebView() async {
    await $(HomePageKeys.webViewTile).tap();
  }

  Future<void> openGps() async {
    await $(HomePageKeys.gpsTile).tap(settlePolicy: SettlePolicy.noSettle);
  }

  Future<void> openConnection() async {
    await $(HomePageKeys.connectionTile).tap();
  }

  Future<void> openForm() async {
    await $(HomePageKeys.formTile).tap();
  }
}
