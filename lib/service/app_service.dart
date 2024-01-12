import 'dart:io';
import 'package:flutter/material.dart';
// import 'package:twogether/utils/toast.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;

class AppService {
  Future<bool?> checkInternet() async {
    bool? internet;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        internet = true;
      }
    } on SocketException catch (_) {
      print('not connected');
      internet = false;
    }
    return internet;
  }

  Future openLink(context, Uri url) async {
    if (await urlLauncher.canLaunchUrl(url)) {
      urlLauncher.canLaunchUrl(url);
    } else {
      // openToast1(context, "Can't launch the url");
    }
  }
}
