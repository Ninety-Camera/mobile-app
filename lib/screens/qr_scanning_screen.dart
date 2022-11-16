import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ninety/api/system_service.dart';
import 'package:ninety/models/user.dart';
import 'package:ninety/screens/dashboard_screen.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRCodeScanningScreen extends StatefulWidget {
  final AppUser appUser;
  const QRCodeScanningScreen({super.key, required this.appUser});

  @override
  State<QRCodeScanningScreen> createState() => _QRCodeScanningScreenState();
}

class _QRCodeScanningScreenState extends State<QRCodeScanningScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  bool _qrScanned = false;

  _registerForSystem(context, barcode) async {
    if (barcode != null && !_qrScanned) {
      var _sysId = barcode!.code;
      _qrScanned = true;
      final fcmToken = await FirebaseMessaging.instance.getToken();
      var systemService = SystemService();
      var appUser = await systemService.susbscribeForSystem(
          widget.appUser, _sysId, fcmToken.toString());
      if (appUser != null) {
        Navigator.of(context).pushAndRemoveUntil(
          _createDashboardRoute(appUser),
          (route) => false,
        );
      } else {
        controller!.resumeCamera();
      }
    }
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller, context) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if (scanData != null) {
        controller!.pauseCamera();
        _registerForSystem(context, scanData);
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) {
                _onQRViewCreated(controller, context);
              },
            ),
          ),
          const Expanded(
            flex: 1,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  "Scan the QR in desktop application to procced",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Route _createDashboardRoute(appUser) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => DashboardScreen(
      appUser: appUser,
    ),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
