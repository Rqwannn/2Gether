import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/detail/presentation/page/unggah_page.dart';
import 'package:twogether/feature/feature.dart';
import 'package:twogether/feature/gmaps/presentation/page/load_maps.dart';
import 'package:twogether/feature/gmaps/presentation/page/maps.dart';
import 'package:twogether/feature/home/presentation/screens/leaderboard.dart';
import 'package:twogether/feature/host/presentation/page/host_page.dart';
import 'package:twogether/feature/host/presentation/screen/form_instansi.dart';
import 'package:twogether/feature/host/presentation/screen/generate_qr_page.dart';
import 'package:twogether/feature/host/presentation/screen/pilih_lokasi.dart';
import 'package:twogether/feature/redeem/presentation/screen/detail_redeem.dart';
import 'package:twogether/feature/redeem/presentation/page/redem_point.dart';
import 'package:twogether/feature/role/presentation/page/role.dart';
import 'package:twogether/feature/splash_info/presentation/presentation.dart';
import 'package:twogether/feature/qrscan/presentation/page/get_point.dart';
import 'package:twogether/feature/qrscan/presentation/page/qrscan.dart';

class PageRouter {
  Route<dynamic>? getRoute(
    RouteSettings settings,
  ) {
    switch (settings.name) {

      //* Splash
      case PagePath.splash:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => SplashPage(
              title: Config().appName,
              subTitle: 'Turn useless into useful',
              logo: Config().appLogo,
              navigator: const LoginPage(),
              durationInSeconds: 2,
            ),
          );
        }

      case PagePath.splashInfo:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const SplashInfoPage(),
          );
        }

      //* Host
      case PagePath.host:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const HostPage(),
          );
        }

      case PagePath.formInstansi:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const FormInstansiPage(),
          );
        }

      case PagePath.pilihLokasi:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const PilihLokasiPage(),
          );
        }

      case PagePath.generateQR:
        {
          final args = settings.arguments as Map<String, dynamic>?;

          final position = args!['position'] as LatLng;
          final address = args['address'] as String;
          
          return _buildRouter(
            settings: settings,
            builder: (args) => GenerateQRPage(
              position: position,
              address: address,
            ),
          );
        }

      //* Redeem Point
      case PagePath.redeem:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const RedemPage(),
          );
        }
      
      case PagePath.detailRedeem:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const DetailRedeem(),
          );
        }

      //* Auth
      case PagePath.login:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const LoginPage(),
          );
        }

      //* Home
      case PagePath.home:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const HomePage(),
          );
        }

      //* Scan
      case PagePath.scan:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const ScanPage(),
          );
        }

      //* QR Scan
      case PagePath.qrscan:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const QrScanPage(),
          );
        }

      case PagePath.getPoint:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const GetPointPage(),
          );
        }

      //* Maps
      case PagePath.maps:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => MapsPage(
              userLocation: args! as LatLng,
            ),
          );
        }

      case PagePath.loadMaps:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const LoadMapsPage(),
          );
        }

      //* Detail
      case PagePath.detail:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => DetailPage(
              args: args! as DetailPageArgs,
            ),
          );
        }
      
      case PagePath.unggah:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const UnggahPage(),
          );
        }

      //* Leaderboard
      case PagePath.leaderboard:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const LeaderboardPage(),
          );
        }
      
      //* Role
      case PagePath.role:
        {
          return _buildRouter(
            settings: settings,
            builder: (args) => const RolePage(),
          );
        }

      default:
        return _buildRouter(
          settings: settings,
          builder: (args) => const LoginPage(),
        );
    }
  }

  Route<dynamic> _buildRouter({
    required RouteSettings settings,
    required Widget Function(Object? arguments) builder,
  }) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => builder(settings.arguments),
    );
  }
}
