import 'package:flutter/material.dart';

class Config {
  final String appName = '2Gether';

  // Colors

  final Color whiteColor = const Color(0xFFFFFFFF);
  final Color grayColor = const Color(0xFF787878);
  final Color lightGrayColor = Color(0xFFE8F2EF);
  final Color greenColor = const Color(0xFF1D5B56);
  final Color semiGreenColor = const Color(0xFF0C8C79);
  final Color youngGreenColor = const Color(0xFF65C074);
  final Color blueOceanColor = const Color(0xFFE9F9EE);
  final Color orangeColor = const Color(0xFFf88753);

  final Color startGradientColor = const Color(0xFFD53E36);
  final Color endGradientColor = const Color(0xFFF99C56);

  final Color startGradientColorBtn = const Color(0xFFC7F3EE);
  final Color endGradientColorBtn = const Color(0xFFD7F1DE);

  final Color startGradientColorCard = const Color(0xFF99EAE5);
  final Color endGradientColorCard = const Color(0xFFBBE6C2);

  final Color startGradientColorIcon = const Color(0xFF1D5B56);
  final Color endGradientColorIcon = const Color(0xFF7EDCBE);

  final Color gold = const Color(0xFFFFAA04);
  final Color silver = const Color(0xFF9E9E9E);
  final Color bronze = const Color(0xFFFF6E04);


  // Image

  final String appLogo = 'assets/core/Logo.png';
  final String mapsRounded = 'assets/core/load_maps.png';
  final String unggahPageImg = 'assets/core/unggah.png';

  final String loginLogo = 'assets/other/login_logo.png';
  final String loginComponent = 'assets/other/login_component.png';
  final String loginRec1 = 'assets/other/login_rectangle_1.png';
  final String loginRec2 = 'assets/other/login_rectangle_2.png';
  final String loginRec3 = 'assets/other/login_rectangle_3.png';
  final String avatar = 'assets/other/avatar.png';
  final String testingProduk = 'assets/other/testing_produk.png';

  final String scanRec1 = 'assets/other/scan_rec_1.png';

  final String defaultUser = 'assets/resource/default_user.png';
  final String googleIcon = 'assets/resource/google_icon.png';
  final String plusIcon = 'assets/resource/plus_icon.png';
  final String lightningIcon = 'assets/resource/lightning_icon.png';
  final String imageIcon = 'assets/resource/image_icon.png';
  final String cameraIcon = 'assets/resource/camera_icon.png';
  final String arrowIcon = 'assets/resource/arrow_icon.png';


  // Splash Intro Image

  final String intro1 = 'assets/core/splash_1.png';
  final String intro2 = 'assets/core/splash_2.png';
  final String intro3 = 'assets/core/splash_3.png';
  final String role = 'assets/core/role_1.png';

  // Size

  final double bigTextSize = 40.0;
  final double titleTextSize = 32.0;
  final double mediumTextSize = 24.0;
  final double smallToMediumTextSize = 18.0;
  final double smallTextSize = 14.0;

  final double distancePerText = 12.0;
  final double distancePerValue = 20.0;

  // Google Maps API

  static const String googleMapsKey = "AIzaSyC6WZ2ezYNvaAs48CV1auf-Mc2QzQdeZRQ";

  static String getNearbyPlacesUrl(double latitude, double longitude, int radius) {
    return 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$latitude,$longitude&radius=$radius&type=tourist_attraction&key=$googleMapsKey';
  }
}
