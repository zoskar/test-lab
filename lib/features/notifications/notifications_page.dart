import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app_settings/app_settings.dart'; // Add this package
// TODO: try to react to denied notifications permission
class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _notifications = FlutterLocalNotificationsPlugin();
  String _status = 'Not sent';
  bool _isLoading = false;
  bool _permissionGranted = false; // Add permission tracking

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    try {
      const initSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      );

      final initialized = await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (response) {
          debugPrint('Notification received: ${response.payload}');
        },
      );

      setState(() => _status = 'Notifications initialized: $initialized');

      // Check permission status after initialization
      await _checkNotificationPermission();
    } catch (e) {
      setState(() => _status = 'Init error: $e');
      debugPrint('Error initializing notifications: $e');
    }
  }

  Future<void> _checkNotificationPermission() async {
    try {
      // For iOS
      final iOS =
          _notifications
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();
      if (iOS != null) {
        final permissionStatus = await iOS.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
        setState(() => _permissionGranted = permissionStatus ?? false);
      }

      // For Android 13+
      final android =
          _notifications
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      if (android != null) {
        final permissionStatus = await android.requestNotificationsPermission();
        setState(() => _permissionGranted = permissionStatus ?? false);
      }

      setState(() {
        _status =
            _permissionGranted ? 'Permission granted' : 'Permission denied';
      });
    } catch (e) {
      setState(() => _status = 'Permission check error: $e');
      debugPrint('Error checking notifications permission: $e');
    }
  }

  Future<void> _showNotification() async {
    if (!_permissionGranted) {
      setState(() => _status = 'Cannot send notification: Permission denied');
      return;
    }

    setState(() {
      _isLoading = true;
      _status = 'Sending...';
    });

    try {
      const notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
          'test_lab_channel',
          'Test Lab Notifications',
          channelDescription: 'Channel for Test Lab app notifications',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      await _notifications.show(
        0,
        'Test Notification',
        'This is a test notification from Test Lab',
        notificationDetails,
      );

      setState(() => _status = 'Notification sent successfully');
    } catch (e) {
      setState(() => _status = 'Error: $e');
      debugPrint('Error showing notification: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _openAppSettings() async {
    await AppSettings.openAppSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Push Notifications Demo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Text(_status, textAlign: TextAlign.center),
                    const SizedBox(height: 10),
                    TextButton(
                      onPressed: _openAppSettings,
                      child: const Text(
                        'Open Settings to Enable Notifications',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                    onPressed:
                        _permissionGranted
                            ? _showNotification
                            : _checkNotificationPermission,
                    child: Text(
                      _permissionGranted
                          ? 'Send Test Notification'
                          : 'Check Permission',
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
