import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:app_settings/app_settings.dart';
import 'notifications_success_page.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final _controller = NotificationsController();

  @override
  void initState() {
    super.initState();
    _controller.initialize(
      stateCallback: () => setState(() {}),
      navigationCallback: _navigateToSuccessScreen,
    );
  }

  void _navigateToSuccessScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const NotificationSuccessPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Push Notifications Demo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            _buildActionButton(),
            const SizedBox(height: 24),
            _buildStatusCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.shade50,
      ),
      child: Column(
        children: [
          Text(
            _controller.status,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: _openAppSettings,
            icon: const Icon(Icons.settings),
            label: const Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton() {
    return _controller.isLoading
        ? const CircularProgressIndicator()
        : ElevatedButton(
          onPressed:
              _controller.permissionGranted
                  ? _controller.showNotification
                  : _controller.checkPermission,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: Text(
            _controller.permissionGranted
                ? 'Send Test Notification'
                : 'Request Permission',
            style: const TextStyle(fontSize: 16),
          ),
        );
  }

  void _openAppSettings() async {
    await AppSettings.openAppSettings();
  }
}

/// Controller class to handle all notification logic
class NotificationsController {
  final _notifications = FlutterLocalNotificationsPlugin();
  String status = 'Initializing...';
  bool isLoading = false;
  bool permissionGranted = false;
  late Function setState;
  late Function() navigateToSuccessScreen;

  /// Initialize the controller and notifications plugin
  Future<void> initialize({
    required Function stateCallback,
    required Function() navigationCallback,
  }) async {
    setState = stateCallback;
    navigateToSuccessScreen = navigationCallback;
    await _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    try {
      const initSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        ),
      );

      await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (response) {
          debugPrint('Notification received: ${response.payload}');
          navigateToSuccessScreen();
        },
      );

      _updateStatus(
        'Ready to use notifications - Tap Request Permission to proceed',
      );
    } catch (e) {
      _updateStatus('Initialization error: $e');
    }
  }

  void _updateStatus(String newStatus) {
    status = newStatus;
    setState();
  }

  Future<void> checkPermission() async {
    try {
      bool hasPermission = false;

      final iOS =
          _notifications
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();
      if (iOS != null) {
        hasPermission =
            await iOS.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
            false;
      }

      final android =
          _notifications
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      if (android != null) {
        hasPermission = await android.requestNotificationsPermission() ?? false;
      }

      permissionGranted = hasPermission;
      _updateStatus(
        hasPermission
            ? 'Ready to send notifications'
            : 'Notification permission denied',
      );
    } catch (e) {
      _updateStatus('Permission check error: $e');
    }
  }

  Future<void> showNotification() async {
    if (!permissionGranted) {
      _updateStatus('Cannot send: Permission denied');
      return;
    }

    isLoading = true;
    _updateStatus('Sending...');

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

      _updateStatus('Notification sent successfully');
    } catch (e) {
      _updateStatus('Error sending notification: $e');
    } finally {
      isLoading = false;
      setState();
    }
  }
}
