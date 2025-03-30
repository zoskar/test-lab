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
  bool _isScanning = true;

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
    if (!_isScanning) {
      return;
    }

    final List<Barcode> barcodes = capture.barcodes;

    for (final barcode in barcodes) {
      if (barcode.rawValue == null) {
        continue;
      }

      setState(() {
        _isScanning = false;
        final scannedValue = barcode.rawValue!;

        if (_isValidUrl(scannedValue)) {
          _scanResult = 'Valid URL: $scannedValue';
        } else {
          _scanResult = 'Invalid URL: $scannedValue';
        }
      });

      break;
    }
  }

  void _resetScanner() {
    setState(() {
      _scanResult = 'Scan a QR code';
      _isScanning = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child:
                _isScanning
                    ? MobileScanner(
                      controller: _controller,
                      onDetect: _onDetect,
                    )
                    : const Center(child: Text('Scan completed')),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _scanResult,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  if (!_isScanning)
                    ElevatedButton(
                      onPressed: _resetScanner,
                      child: const Text('Scan Again'),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
