import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite/tflite.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';
import 'package:twogether/main.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  bool isWorking = false;
  bool flashMode = false;
  bool cameraMode = false;

  CameraImage? imgCamer;
  CameraController? camController;
  int selectedCameraIndex = 0;

  initCamera(CameraController newController) {
    camController = newController;

    camController!.initialize().then((value) {
      if (!mounted) {
        return;
      }

      setState(() {
        camController!.startImageStream((image) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamer = image,
                  runModelOnStreamFrames(),
                }
            });
      });
    });
  }

  cekFlashMode() {
    if (flashMode) {
      camController!.setFlashMode(FlashMode.torch);
    } else {
      camController!.setFlashMode(FlashMode.off);
    }
  }

  setFlashMode() {
    setState(() {
      flashMode = !flashMode;
    });
  }

  setCameraMode() async {
    if (cameras!.length > 1) {
      selectedCameraIndex = (selectedCameraIndex + 1) % cameras!.length;
      await changePositionCameraController(cameras![selectedCameraIndex]);
    }
  }

  Future<void> changePositionCameraController(
      CameraDescription cameraDescription) async {
    if (camController != null) {
      await camController!.dispose();
    }

    camController = CameraController(
      cameraDescription,
      ResolutionPreset.medium,
    );

    try {
      initCamera(camController!);
    } catch (e) {
      print('Error inisialisasi kamera: $e');
    }

    if (mounted) {
      setState(() {});
    }
  }

  runModelOnStreamFrames() async {
    if (imgCamer != null) {
      

      isWorking = false;
    }
  }

  @override
  void initState() {
    super.initState();

    initCamera(CameraController(cameras![0], ResolutionPreset.medium));

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushNamed(context, PagePath.getPoint);
    });
    
  }

  @override
  void dispose() async {
    super.dispose();
    await Tflite.close();
    camController!.dispose();
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
          "Memindai Kode QR",
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
        children: [

          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pindai Kode QR',
                  style: TextStyle(
                      color: Config().greenColor,
                      fontSize: Config().titleTextSize,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Config().distancePerText),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  height: 450,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: imgCamer == null
                          ? const Text(
                              "Kamera Tidak Tersedia",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : AspectRatio(
                              aspectRatio: 9 / 13,
                              child: CameraPreview(camController!),
                            ),
                    ),
                  ),
                ),
           
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                
                Container(
                  color: Config().endGradientColorBtn,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      
                      InkWell(
                        onTap: () {
                          setFlashMode();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Flash Mode"),
                                content: flashMode
                                    ? const Text("On")
                                    : const Text("Off"),
                              );
                            },
                          );
                        },
                        child: Image.asset(Config().lightningIcon,
                            width: 50, height: 50),
                      ),
                      InkWell(
                        onTap: () async {
                          setCameraMode();
                        },
                        child: Image.asset(Config().cameraIcon,
                            width: 50, height: 50),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }

}
