import 'package:patrol/patrol.dart';
import 'package:test_lab/keys.g.dart';

class QRCodePageObject {
  QRCodePageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> checkIfImageLoaded() async {
    await $('Image loaded successfully').waitUntilVisible();
    await $(QrPageKeys.loadedImage).waitUntilVisible();
  }
}
