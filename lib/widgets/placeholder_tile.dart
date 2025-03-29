import 'package:flutter/material.dart';
import 'tile.dart';

class FormsTile extends StatelessWidget {
  const FormsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(icon: Icons.description, text: 'Forms', onTap: () {});
  }
}

class DarkModeTile extends StatelessWidget {
  const DarkModeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(icon: Icons.dark_mode, text: 'Dark mode', onTap: () {});
  }
}

class NotificationsTile extends StatelessWidget {
  const NotificationsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(
      icon: Icons.notifications,
      text: 'Notifications',
      onTap: () {},
    );
  }
}

class PermissionsTile extends StatelessWidget {
  const PermissionsTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(icon: Icons.security, text: 'Permissions', onTap: () {});
  }
}

class QRCodeTile extends StatelessWidget {
  const QRCodeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(icon: Icons.qr_code, text: 'QR Code', onTap: () {});
  }
}

class BiometricTile extends StatelessWidget {
  const BiometricTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(icon: Icons.fingerprint, text: 'Biometric', onTap: () {});
  }
}

class GPSTile extends StatelessWidget {
  const GPSTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(icon: Icons.location_on, text: 'GPS', onTap: () {});
  }
}

