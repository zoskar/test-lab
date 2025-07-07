import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.g.dart';

class ConnectionPageObject {
  ConnectionPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> checkIfConnected() async {
    await $(ConnectionPageKeys.connectedStatus).waitUntilVisible();
  }

  Future<void> checkIfDisconnected() async {
    await $(ConnectionPageKeys.disconnectedStatus).waitUntilVisible();
  }
}
