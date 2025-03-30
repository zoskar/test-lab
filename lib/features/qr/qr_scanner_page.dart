import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerPageState();
}

class _QRScannerPageState extends State<QRScannerPage> {
  final MobileScannerController _controller = MobileScannerController();
  String _status = 'Scan a QR code';
  bool _hasScanned = false;
  String? _imageUrl;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    final barcode = capture.barcodes.firstWhere(
      (barcode) => barcode.rawValue != null,
      orElse: () => const Barcode(),
    );

    if (barcode.rawValue == null) {
      return;
    }

    final scannedValue = barcode.rawValue!;
    _processScannedValue(scannedValue);
  }

  void _processScannedValue(String scannedValue) {
    setState(() {
      _hasScanned = true;
      _imageUrl =
          scannedValue.startsWith(RegExp('https?://'))
              ? scannedValue
              : 'https://${scannedValue.replaceAll(RegExp('^/+'), '')}';
      _status = 'Loading image...';
    });
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _status,
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  if (_imageUrl != null)
                    Expanded(
                      child: Image.network(
                        _imageUrl!,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            // Image loaded successfully
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              setState(
                                () => _status = 'Image loaded successfully',
                              );
                            });
                            return child;
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(
                              () => _status = 'Failed to load image from URL',
                            );
                          });
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 48,
                            ),
                          );
                        },
                      ),
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
