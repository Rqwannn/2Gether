import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:twogether/config/config.dart';
import 'package:twogether/feature/feature.dart';
import 'package:twogether/locator.dart';

class SplashPage extends StatefulWidget {
  final String title;
  final String subTitle;
  final double logoWidth;
  final String logo;
  final int durationInSeconds;
  final dynamic navigator;

  final Future<Object>? futureNavigator;

  const SplashPage({
    super.key,
    required this.logo,
    required this.title,
    required this.subTitle,
    this.futureNavigator,
    this.navigator,
    this.durationInSeconds = 3,
    this.logoWidth = 150,
  });

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();

    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });

    checkHostExistence();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        if (sl<UserCubit>().state.isAlreadyLogin) {
          Navigator.pushReplacementNamed(context, PagePath.home);
        } else {
          Navigator.pushReplacementNamed(context, PagePath.splashInfo);
          // Navigator.pushReplacementNamed(context, PagePath.login);
        }
      },
    );
  }

  Future<void> checkHostExistence() async {
    bool isHostExisting = await isHostExist(sl<UserCubit>().state.userEntity!.id);

    if (isHostExisting) {
      Navigator.pushReplacementNamed(context, PagePath.host);
    }
  }

  Future<bool> isHostExist(String idAccount) async {
    try {
      CollectionReference hostsCollection = FirebaseFirestore.instance.collection('host');
      QuerySnapshot querySnapshot = await hostsCollection.where('id_account', isEqualTo: idAccount).get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking host existence: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        widget.logo,
                        height: widget.logoWidth,
                      ),
                      Text(
                        widget.title,
                        style: TextStyle(
                          fontSize: Config().titleTextSize,
                          fontWeight: FontWeight.bold,
                          color: Config().greenColor,
                        ),
                      ),
                      Text(
                        widget.subTitle,
                        style: TextStyle(
                          fontSize: Config().smallTextSize,
                          color: Config().greenColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
