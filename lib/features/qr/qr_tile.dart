import 'package:common_ui/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:test_lab/features/qr/qr_scanner_page.dart';
import 'package:test_lab/keys.dart';

class QRCodeTile extends StatelessWidget {
  const QRCodeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return TLTile(
      key: keys.homePage.qrTile,
      onTap:
          () => Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (context) => const QRScannerPage(),
            ),
          ),
      icon: Icons.qr_code_scanner,
      text: 'QR Code',
    );
  }
}
