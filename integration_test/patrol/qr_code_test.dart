import 'dart:io';

import 'package:patrol/patrol.dart';

import '../util/common.dart';
import 'pages/home_pom.dart';
import 'pages/qr_code_pom.dart';

void main() {
  // camera is not available on iOS simulator
  if (Platform.isAndroid) {
    patrolTest('tests QR code scanning', ($) async {
      final homePage = HomePageObject($);
      final qrCodePage = QRCodePageObject($);

      await Common.openApp($);
      await homePage.openQrScanner();
      await $.native2.grantPermissionOnlyThisTime();
      await qrCodePage.checkIfImageLoaded();
    });
  }
}
