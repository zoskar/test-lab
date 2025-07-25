import 'package:flutter/material.dart';
import 'package:test_lab/features/connection/connection_tile.dart';
import 'package:test_lab/features/form/form_tile.dart';
import 'package:test_lab/features/gps/gps_tile.dart';
import 'package:test_lab/features/login/auth_tile.dart';
import 'package:test_lab/features/notifications/notifications_tile.dart';
import 'package:test_lab/features/qr/qr_tile.dart';
import 'package:test_lab/features/webView/web_view_tile.dart';

class TestLabScreen extends StatelessWidget {
  const TestLabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test Scenarios'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          children: const [
            AuthTile(),
            ConnectionTile(),
            WebViewTile(),
            NotificationsTile(),
            QRCodeTile(),
            GPSTile(),
            FormsTile(),
          ],
        ),
      ),
    );
  }
}
