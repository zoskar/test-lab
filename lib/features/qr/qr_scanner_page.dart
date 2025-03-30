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
  bool _hasScanned = false;
  String? _imageUrl;
  bool _hasError = false;

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
      _hasError = false;
      _imageUrl =
          scannedValue.startsWith(RegExp('https?://'))
              ? scannedValue
              : 'https://${scannedValue.replaceAll(RegExp('^/+'), '')}';
      _scanResult = 'Attempting to load image';
    });
  }

  void _handleImageError() {
    if (!_hasError) {
      setState(() {
        _hasError = true;
        _scanResult = 'Cannot load as image: $_imageUrl';
      });
    }
  }

  void _handleImageLoaded() {
    setState(() {
      _scanResult = 'Image loaded successfully';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: Column(
        children: [if (!_hasScanned) _buildScanner(), _buildResultDisplay()],
      ),
    );
  }

  Widget _buildScanner() {
    return Expanded(
      flex: 2,
      child: MobileScanner(controller: _controller, onDetect: _onDetect),
    );
  }

  Widget _buildResultDisplay() {
    return Expanded(
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
            const SizedBox(height: 16),
            if (_imageUrl != null)
              Expanded(
                child:
                    _hasError
                        ? const Center(child: Text('Error loading image'))
                        : _buildNetworkImage(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkImage() {
    return Image.network(
      _imageUrl!,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _handleImageLoaded();
          });
          return child;
        }
        return const Center(child: CircularProgressIndicator());
      },
      errorBuilder: (context, error, stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _handleImageError();
        });
        return const Center(child: Text('Failed to load image'));
      },
    );
  }
}
