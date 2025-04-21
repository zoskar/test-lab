import 'package:patrol/patrol.dart';

import 'common.dart';

void main() {
  patrolTest('tests email password login', ($) async {

    await Common.openApp($);

    await $('Login').tap();
  });
}
