import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController _controller = MobileScannerController();
  String _scanResult = 'Scan a QR code';
  bool _hasScanned = false; // Track whether scan is complete

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _isValidUrl(String url) {
    final urlRegExp = RegExp(
      '^(http|https)://'
      r'([a-zA-Z0-9]([a-zA-Z0-9\-]{0,61}[a-zA-Z0-9])?\.)+[a-zA-Z]{2,6}'
      r'(/[\w\-\.,@?^=%&:/~\+#]*)*',
      caseSensitive: false,
    );
    return urlRegExp.hasMatch(url);
  }

  void _onDetect(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;

    for (final barcode in barcodes) {
      if (barcode.rawValue == null) {
        continue;
      }

      setState(() {
        final scannedValue = barcode.rawValue!;

        if (_isValidUrl(scannedValue)) {
          _scanResult = 'Valid URL: $scannedValue';
        } else {
          _scanResult = 'Invalid URL: $scannedValue';
        }

        _hasScanned = true; // Mark scan as complete
      });

      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: Column(
        children: [
          if (!_hasScanned)
            Expanded(
              flex: 2,
              child: MobileScanner(
                controller: _controller,
                onDetect: _onDetect,
              ),
            ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Text(
                _scanResult,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
