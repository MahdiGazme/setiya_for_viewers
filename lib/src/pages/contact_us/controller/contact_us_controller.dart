import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../view/dialog/developer_note_dialog.dart';

class ContactUsController extends GetxController {
  int tapCount = 0;
  final _debouncer = Debouncer(
    delay: const Duration(
      milliseconds: 1500,
    ),
  );

  final String _instagram = 'https://www.instagram.com/td.setiya/';
  final String _publicPhoneNumber = 'tel://+989036538676';
  final String _managerPhoneNumber = 'tel://+989016604280';
  final String _email = 'td.setiya.ir@gmail.com';

  void onInstagramLinkTap() async {
    final uri = Uri.parse(_instagram);
    if (await canLaunchUrl(uri)) {
      await launchUrl(
        uri,
        mode: Platform.isIOS
            ? LaunchMode.platformDefault
            : LaunchMode.externalNonBrowserApplication,
      );
    } else {
      throw 'could not lunch instagram';
    }
  }

  void onPublicPhoneButtonTap() async {
    final url = Uri.parse(_publicPhoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'could not lunch phone';
    }
  }

  void onManagerPhoneButtonTap() async {
    final url = Uri.parse(_managerPhoneNumber);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'could not lunch phone';
    }
  }

  void onDeveloperLogTap() {
    tapCount++;
    _debouncer.call(() {
      tapCount = 0;
    });
  }

  void onSetiyaLogoLongPress() {
    if (tapCount == 10) {
      Get.dialog(
        const DeveloperNoteDialog(),
      );
    }
  }

  void onEmailButtonTap() => Clipboard.setData(ClipboardData(text: _email));
}
