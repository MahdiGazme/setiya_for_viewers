import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../../../../components/milky_scaffold/view/milky_scaffold.dart';
import '../../../../../../infrastructures/themes/custom_milky_theme.dart';
import '../../../../../../infrastructures/utils/utils.dart';

class QrcodeScanner extends StatefulWidget {
  const QrcodeScanner({final Key? key}) : super(key: key);

  @override
  State<QrcodeScanner> createState() => _QrcodeScannerState();
}

class _QrcodeScannerState extends State<QrcodeScanner> {
  bool isInvalidCode = false;

  QRViewController? qrViewController;

  final qrKey = GlobalKey(debugLabel: 'QR');

  double cutOutSize(final double size) => size * 0.8;

  void onQrcodeCreated(final QRViewController controller) async {
    setState(() {
      qrViewController = controller;
      controller.resumeCamera();
    });

    controller.scannedDataStream.listen((final event) async {
      if (event.code != null) {
        await controller.pauseCamera();
        if (isValidateQrcodeResult(event.code!)) {
          Get.back(
            result: event.code,
          );
        } else {
          await controller.resumeCamera();
          setState(() {
            isInvalidCode = true;
          });
          await Future.delayed(const Duration(seconds: 1));
          setState(() {
            isInvalidCode = false;
          });
        }
      }
    });
  }

  bool isValidateQrcodeResult(final String qrcodeResult) {
    final regex = RegExp(
      '(^([a-z0-9]{8})-([a-z0-9]{4})-([a-z0-9]{4})'
      r'-([a-z0-9]{4})-([a-z0-9]{12})$)',
    );

    return regex.hasMatch(qrcodeResult);
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  // In order to get hot reload to work we need to pause the camera if the
  // platform is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await qrViewController!.pauseCamera();
    } else if (Platform.isIOS) {
      await qrViewController!.resumeCamera();
    }
  }

  @override
  Widget build(final BuildContext context) => MilkyScaffold(
        body: SafeArea(
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              _qrView(context),
              _message(context),
            ],
          ),
        ),
      );

  Positioned _message(final BuildContext context) => Positioned(
        bottom: Utils.largeSpace,
        child: DecoratedBox(
          decoration: _messageDecoration(),
          child: Padding(
            padding: Utils.smallPadding,
            child: Text(
              isInvalidCode
                  ? 'کد الکترونیکی نا معتبر است'
                  : 'کد الکترونیکی را اسکن کنید',
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: CustomMilkyTheme.secondaryColor,
                  ),
            ),
          ),
        ),
      );

  BoxDecoration _messageDecoration() => BoxDecoration(
        color: isInvalidCode
            ? CustomMilkyTheme.dangerColor
            : CustomMilkyTheme.infoColor,
        borderRadius: BorderRadius.circular(
          CustomMilkyTheme.borderRadiusSemiRound,
        ),
      );

  QRView _qrView(final BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQrcodeCreated,
        overlay: QrScannerOverlayShape(
          borderRadius: CustomMilkyTheme.borderRadiusSemiRound,
          borderColor: CustomMilkyTheme.primaryColor.shade700,
          borderLength: 27,
          // count cutOutSize by Screen width or breakpoint size
          cutOutSize: MediaQuery.of(context).size.width < 600
              ? cutOutSize(MediaQuery.of(context).size.width)
              : cutOutSize(600),
          borderWidth: 7,
        ),
        formatsAllowed: const [
          BarcodeFormat.qrcode,
        ],
      );
}
