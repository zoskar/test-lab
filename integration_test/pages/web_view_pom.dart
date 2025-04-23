import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class WebViewPageObject {
  WebViewPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> addElement() async {
    await $.native2.tap(
      NativeSelector(android: AndroidSelector(text: 'Add Element')),
    );
  }

  Future<bool> checkCount(int expectedCount) async {
    for (var attempt = 0; attempt < 3; attempt++) {
      final elements = await $.native2.getNativeViews(
        NativeSelector(android: AndroidSelector(text: 'Delete')),
      );
      final actualCount = elements.androidViews.length;

      if (actualCount == expectedCount) {
        return true;
      }
      await Future.delayed(const Duration(seconds: 1), () {});
    }
    return false;
  }
}
