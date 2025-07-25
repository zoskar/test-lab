import 'package:common_ui/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:test_lab/features/notifications/notifications_page.dart';
import 'package:test_lab/keys.dart';

class NotificationsTile extends StatelessWidget {
  const NotificationsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(
      key: keys.homePage.notificationsTile,
      icon: Icons.notifications,
      text: 'Notifications',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute<void>(builder: (context) => const NotificationsPage()),
        );
      },
    );
  }
}
