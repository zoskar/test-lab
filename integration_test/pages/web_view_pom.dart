import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';

class WebViewPageObject {
  WebViewPageObject(this.$);

  final PatrolIntegrationTester $;

  Future<void> addElement() async {
    await $.native2.tap(
      NativeSelector(
        android: AndroidSelector(text: 'Add Element'),
        ios: IOSSelector(label: 'Add Element'),
      ),
    );
  }

  Future<bool> deleteButtonVisible() async {
    var i = 0;
    var nativeViewsList = List<dynamic>.empty();

    while (i < 5 && nativeViewsList.isEmpty) {
      i++;
      nativeViewsList = await $.native.getNativeViews(
        Selector(text: 'Delete'),
        appId: 'io.github.zoskar.testlab',
      );
      if (nativeViewsList.isNotEmpty) {
        return true;
      }
      await Future.delayed(const Duration(seconds: 1), () {});
    }
    return false;
  }
}
