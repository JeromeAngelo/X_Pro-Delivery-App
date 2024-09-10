import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrViewExample extends StatefulWidget {
  const QrViewExample({super.key});

  @override
  State<QrViewExample> createState() => _QrViewExampleState();
}

class _QrViewExampleState extends State<QrViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Handle the scanned QR code data
      print(scanData.code);
      Navigator.of(context).pop(); // Return to previous screen
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
