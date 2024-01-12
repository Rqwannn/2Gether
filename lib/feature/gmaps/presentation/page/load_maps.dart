import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';

class LoadMapsPage extends StatefulWidget {
  const LoadMapsPage({super.key});

  @override
  State<LoadMapsPage> createState() => _LoadMapsPageState();
}

class _LoadMapsPageState extends State<LoadMapsPage> {

  LatLng? userLocation;

  Future<bool> _requestLocationPermission() async {
    final status = await Permission.locationWhenInUse.request();

    if (status == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }

  Future<Position?> _getLocation() async {
    if (await _requestLocationPermission()) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        return position;
      } catch (e) {
        return null;
      }
    } else {
      // Izin lokasi tidak diberikan oleh pengguna.
      return null;
    }
  }

    @override
  void initState() {
    super.initState();

    _getLocation().then((position) {
      setState(() {
        if (position != null) {

          // Set lokasi pengguna sebagai initialCameraPosition
          userLocation = LatLng(position.latitude, position.longitude);

          Future.delayed(Duration(seconds: 2), () {
            Navigator.pushNamed(
              context, 
              PagePath.maps,
              arguments: userLocation
            );
          });
        
        } else {
          // Handle jika posisi null (misalnya, izin lokasi tidak diberikan)
          print("Posisi pengguna null.");
        }
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Config().greenColor),
        ),
        title: Text(
          "Mencari Lokasi",
          style: TextStyle(
            fontSize: Config().mediumTextSize,
            fontWeight: FontWeight.bold,
            color: Config().greenColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue + 30),
              child: Text(
                'Mencari Tempat Sampah Terdekat...',
                style: TextStyle(
                  fontSize: Config().mediumTextSize,
                  fontWeight: FontWeight.bold,
                  color: Config().greenColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: Config().distancePerValue),

            ClipOval(
              child: Image.asset(
                Config().mapsRounded,
                width: 200.0,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),

          ],
        ),
      ),
    );
  }

}