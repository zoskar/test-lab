import 'package:flutter_test/flutter_test.dart';
import 'package:patrol/patrol.dart';
import 'pages/home_pom.dart';
import 'pages/web_view_pom.dart';
import 'util/common.dart';

void main() {
  patrolTest('test interacting with the-internet page', ($) async {
    final homePage = HomePageObject($);
    final webViewPage = WebViewPageObject($);

    await Common.openApp($);
    await homePage.openWebView();
    await webViewPage.addElement();
    expect(await webViewPage.deleteButtonVisible(), true);
  });
}
