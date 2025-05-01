import 'package:flutter_test/flutter_test.dart';
import 'package:test_lab/keys.dart';

class HomePageObject {
  HomePageObject(this.tester);

  final WidgetTester tester;

  Future<void> openLogin() async {
    await tester.tap(find.byKey(HomePageKeys.loginTile));
    await tester.pumpAndSettle();
  }

  Future<void> openForm() async {
    await tester.tap(find.byKey(HomePageKeys.formTile));
    await tester.pumpAndSettle();
  }
}
