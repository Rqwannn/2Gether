import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tflite/tflite.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';
import 'package:twogether/feature/detail/detail.dart';
import 'package:twogether/main.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class DetectionData {
  String label;
  double confidence;
  int count;

  DetectionData(
      {required this.label, required this.confidence, required this.count});
}

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isWorking = false;
  bool flashMode = false;
  bool cameraMode = false;

  CameraImage? imgCamer;
  CameraController? camController;

  String result = "";
  String imgFile = "";

  double accuracy = 0;
  int count = 0;
  int selectedCameraIndex = 0;

  List<DetectionData> detectionList = [];

  loadModel() async {
    await Tflite.loadModel(
      model: "assets/model/mobilenet_v2_1.4_224.tflite",
      labels: "assets/model/mobilenet_v1_1.0_224.txt");
  }

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
      var recognition = await Tflite.runModelOnFrame(
          bytesList: imgCamer!.planes.map((e) {
            return e.bytes;
          }).toList(),
          imageHeight: imgCamer!.height,
          imageWidth: imgCamer!.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 1,
          threshold: 0.1,
          asynch: true);

      result = "";
      accuracy = 0;
      count = 0;

      // detectionList = [];

      recognition!.forEach((response) {
        String label = response["label"];
        double confidence = response["confidence"] as double;

        // int index = detectionList.indexWhere((element) => element.label == label);

        // if (index != -1) {
        //   // Jika label sudah terdeteksi sebelumnya, tambahkan count
        //   detectionList[index].count++;
        // } else {
        //   // Jika label belum terdeteksi, tambahkan ke list
        //   detectionList.add(DetectionData(label: label, confidence: confidence, count: 1));
        // }

        result = label;
        accuracy = confidence;
        count += 1;
      });

      setState(() {
        result;
        count;
        // detectionList;
      });

      isWorking = false;
    }
  }

  toBackPack() async {
    camController!.stopImageStream();
    cekFlashMode();

    imgFile = "";

    await camController!.takePicture().then((XFile file) {
      imgFile = file.path;
      isWorking = false;
    });

    camController!.setFlashMode(FlashMode.off);
  }

  saveData(UserEntity user) async {
    if (result.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Failed"),
            content: Text("Failed"),
          );
        },
      );

      Navigator.pushNamedAndRemoveUntil(
        context,
        PagePath.scan,
        (Route<dynamic> route) => false,
      );
    } else {
      CollectionReference backpacks =
          FirebaseFirestore.instance.collection('backpack');
      firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'backpack/${user.id}_${DateTime.now().millisecondsSinceEpoch}.png');

      await ref.putFile(File(imgFile));

      String imageUrl = await ref.getDownloadURL();

      await backpacks.add({
        'title': result,
        'user': user.id,
        'count': count,
        'image': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        result = '';
        accuracy = 0;
        count = 0;
      });

      Navigator.pushNamed(
        context,
        PagePath.loadMaps,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    loadModel();
    initCamera(CameraController(cameras![0], ResolutionPreset.medium));
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
          "Ambil Foto",
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
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Capture Trash',
                  style: TextStyle(
                      color: Config().greenColor,
                      fontSize: Config().titleTextSize,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: Config().distancePerText),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  height: 320,
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
                            // aspectRatio: 8.8 / 9,
                            aspectRatio: 10.5 / 12,
                            child: CameraPreview(camController!),
                          ),
                    ),
                  ),
                ),
                SizedBox(height: Config().distancePerText),
                Text(
                  result,
                  style: TextStyle(
                      color: Config().greenColor,
                      fontSize: Config().smallToMediumTextSize,
                      fontWeight: FontWeight.bold),
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Config().startGradientColorBtn,
                          Config().endGradientColorBtn
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog(
                                title: Text("Loading"),
                                content: Text("Loading"),
                              );
                            },
                          );

                          await toBackPack();

                          Navigator.of(context).pop();

                          _showConfirmationPopup(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          disabledForegroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Turn into your backpack',
                                style: TextStyle(
                                  color: Config().greenColor,
                                  fontSize: Config().smallToMediumTextSize,
                                ),
                              ),
                              SizedBox(height: Config().distancePerValue - 10),
                              Image.asset(Config().arrowIcon,
                                  width: 50, height: 50),
                            ])),
                  ),
                ),
                SizedBox(height: Config().distancePerValue),
                Container(
                  color: Config().endGradientColorBtn,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // InkWell(
                      //   onTap: () {
                      //     print("Image");
                      //   },
                      //   child: Image.asset(Config().imageIcon, width: 50, height: 50),
                      // ),
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

  Future<void> _showConfirmationPopup(BuildContext context) async {
    UserEntity? userEntity = context.read<UserCubit>().state.userEntity;

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.file(
                File(imgFile),
                width: 150,
                height: 150,
              ),
              SizedBox(height: Config().distancePerValue),
              Text(
                result,
                style: TextStyle(
                    color: Config().greenColor,
                    fontSize: Config().smallToMediumTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                initCamera(
                    CameraController(cameras![0], ResolutionPreset.medium));
                    
                Navigator.pushNamed(
                  context,
                  PagePath.detail,
                  arguments: const DetailPageArgs(
                    id: "id",
                    image: "https://firebasestorage.googleapis.com/v0/b/twogether-app-project.appspot.com/o/receip%2Fcardboard_mask.png?alt=media&token=f34cae4d-c10c-43d1-845a-16176d9bf0b9",
                    title: "Cardboard Mask",
                  ),
                );
              },
              child: Text(
                'Buang',
                style: TextStyle(
                    color: Config().greenColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog(
                      title: Text("Loading"),
                      content: Text("Loading"),
                    );
                  },
                );

                saveData(userEntity!);

              },
              child: Text(
                'Daur Ulang',
                style: TextStyle(
                    color: Config().greenColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
