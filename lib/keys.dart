import 'package:common_ui/widgets/keys.dart' as ds;
import 'package:test_lab/features/connection/keys.dart';
import 'package:test_lab/features/form/keys.dart';
import 'package:test_lab/features/gps/keys.dart';
import 'package:test_lab/features/homePage/keys.dart';
import 'package:test_lab/features/login/keys.dart';
import 'package:test_lab/features/notifications/keys.dart';
import 'package:test_lab/features/qr/keys.dart';

final keys = Keys();

class Keys {
  final widgetKeys = ds.widgetKeys;
  final homePage = HomePageKeys();
  final loginPage = LoginPageKeys();
  final connectionPage = ConnectionPageKeys();
  final notificationsPage = NotificationsPageKeys();
  final qrPage = QRPageKeys();
  final gpsPage = GpsPageKeys();
  final eventListPage = EventListPageKeys();
  final eventFormPage = EventFormKeys();
}
