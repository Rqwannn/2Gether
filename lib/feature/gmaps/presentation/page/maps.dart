import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:twogether/config/config.dart';

import 'package:http/http.dart' as http;
import 'package:twogether/feature/common/common.dart';

class MapsPage extends StatefulWidget {
  const MapsPage({
    super.key,
    required this.userLocation
  });

  final LatLng userLocation;

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {

  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  late StreamSubscription<Position> positionStreamSubscription;
  LatLng placeLocation = const LatLng(-6.1846387, 106.87127);
  LatLng user = const LatLng(0, 0);

  void sendRequest() async {
    String route = await getRouteCoordinates();
    createRoute(route);
  }

  @override
  void dispose() {
    // Hapus langganan saat widget di-unmount
    positionStreamSubscription.cancel();
    super.dispose();
  }

  
  Future<void> requestPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<void> getPositionStream() async {
    late LocationSettings locationSettings;

    if (Platform.isAndroid) {
      locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 1),
      );
    } else if (Platform.isIOS || Platform.isMacOS) {
      locationSettings = AppleSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
        pauseLocationUpdatesAutomatically: true,
      );
    } else {
      locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      );
    }
    
    positionStreamSubscription = Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      setState(() {
        user = LatLng(position.latitude, position.longitude);
      });
    });
   }

  @override
  void initState() {
    super.initState();
    user = widget.userLocation;

    requestPermission();
    getPositionStream();
    

    setState(() {
      _markers.add(
          Marker(
            markerId: const MarkerId('User Location'),
            position: user,
            infoWindow: const InfoWindow(
              title: 'Lokasi Anda',
              snippet: 'Ini adalah lokasi Anda saat ini.',
            ),
          ),
        );

      _markers.add(
        Marker(
          markerId: const MarkerId('Place Location'),
          position: placeLocation,
          infoWindow: const InfoWindow(
            title: 'Lokasi Tempat Tujuan Anda',
            snippet: 'Ini adalah lokasi tempat tujuan Anda saat ini.',
          ),
        ),
      );

      sendRequest();

    });
  }

  void createRoute(String encodedPoly) {
    _polylines.add(Polyline(
      polylineId: PolylineId(user.toString()),
      width: 4,
      points: convertToLatLng(decodePoly(encodedPoly)),
      color: Colors.red,
    ));
  }

  Future<String> getRouteCoordinates() async {
    String url = Config.getDirection(user, placeLocation);

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> values = jsonDecode(response.body);

    setState(() {});

    return values["routes"][0]["overview_polyline"]["points"];
  }

  List<LatLng> convertToLatLng(List<dynamic> points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  List<double> decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = <double>[];
    int index = 0;
    int len = poly.length;
    int c = 0;

    do {
      var shift = 0;
      int result = 0;

      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);

      if (result & 1 == 1) {
        result = ~result;
      }

      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    return lList;
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
      body: Stack(
        children: <Widget>[
          
          GoogleMap(
            compassEnabled: false,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: const CameraPosition(
              target: LatLng(-6.2088, 106.8456), // Kordinat Jakarta
              zoom: 13.0,
            ),
            onMapCreated: (controller) {
              _controller = controller;

              _controller?.animateCamera(
                CameraUpdate.newLatLngZoom(
                  widget.userLocation,
                  14.0,
                ),
              );
            },
            markers: _markers,
            polylines: _polylines,
          ),

          Positioned(
            bottom: 0,
            right: 20,
            left: 20,
            child: Container(
              width: 200.0,
              padding: EdgeInsets.all(Config().distancePerValue),
              decoration: BoxDecoration(
                color: Config().blueOceanColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  ElevatedButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                        child: Text(
                        'Memindai Kode QR',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Config().smallToMediumTextSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Config().greenColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () =>
                      Navigator.pushNamed(
                        context,
                        PagePath.qrscan,
                      )
                  ),

                  SizedBox(height: Config().distancePerValue),

                  ElevatedButton(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      width: double.infinity,
                        child: Text(
                        'Cancel',
                        style: TextStyle(
                          color: Config().grayColor,
                          fontSize: Config().smallToMediumTextSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Config().whiteColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Config().greenColor),
                      ),
                    ),
                    onPressed: () =>
                      Navigator.pop(context)
                  ),

                ],
              ),
            ),
          )
          
        ],
      ),
    );
  }
}