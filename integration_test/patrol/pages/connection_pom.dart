import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class ConnectionPageObject {
  ConnectionPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> checkIfConnected() async {
    await $(keys.connectionPage.connectedStatus).waitUntilVisible();
  }

  Future<void> checkIfDisconnected() async {
    await $(keys.connectionPage.disconnectedStatus).waitUntilVisible();
  }
}
