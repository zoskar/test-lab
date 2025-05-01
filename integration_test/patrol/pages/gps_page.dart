import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.dart';

class GpsPageObject {
  GpsPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> isSuccessDialogVisible() async {
    await $(GpsPageKeys.successDialog).waitUntilVisible();
  }
}
