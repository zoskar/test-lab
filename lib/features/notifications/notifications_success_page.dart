import 'package:flutter/material.dart';
import 'package:test_lab/keys.g.dart';

class NotificationSuccessPage extends StatelessWidget {
  const NotificationSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notification Opened')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              'Notifications open success',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'You successfully opened this screen by tapping on a notification.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              key: NotificationsPageKeys.notificationGoBackButton,
              onPressed:
                  () =>
                      Navigator.of(context).popUntil(ModalRoute.withName('/')),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
