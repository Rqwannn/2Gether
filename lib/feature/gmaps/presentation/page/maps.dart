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

  @override
  void initState() {
    super.initState();

    setState(() {
      _markers.add(
          Marker(
            markerId: MarkerId('userLocation'),
            position: widget.userLocation,
            infoWindow: const InfoWindow(
              title: 'Lokasi Anda',
              snippet: 'Ini adalah lokasi Anda saat ini.',
            ),
          ),
        );

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