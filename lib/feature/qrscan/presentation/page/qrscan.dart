import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';
import 'package:twogether/locator.dart';
import 'package:twogether/service/notification_controller.dart';

class QrScanPage extends StatefulWidget {
  const QrScanPage({super.key});

  @override
  State<QrScanPage> createState() => _QrScanPageState();
}

class _QrScanPageState extends State<QrScanPage> {
  late QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  CameraFacing currentCameraFacing = CameraFacing.back;
  bool isFlashOn = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();

    // if (Platform.isAndroid) {
    //   controller!.pauseCamera();
    // } else if (Platform.isIOS) {
    //   controller!.resumeCamera();
    // }

  }

  Future<void> tambahPoin(String userId) async {
    try {
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      DocumentSnapshot userSnapshot = await userRef.get();

      // Mengambil nilai poin saat ini
      int poinSaatIni = userSnapshot['poin'] ?? 0;
      String username = userSnapshot['username'];

      int poinBaru = poinSaatIni + 10;

      await userRef.update({'poin': poinBaru});

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: 'Scan QR Berhasil!',
          body: 'Berhasil menambahkan 10 poin ke pengguna dengan Username: $username',
        ),
      );

    } catch (e) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: 'Scan QR Gagal!',
          body: 'Terdapat Kesalah Pada Sistem Mohon Untuk Menghubungi Customer Service',
        ),
      );
    }
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      String? qrCodeData = scanData.code;

      if(qrCodeData != null){
        controller!.pauseCamera();
        
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              title: Text("Loading"),
              content: Text("Loading"),
            );
          },
        );

        tambahPoin(sl<UserCubit>().state.userEntity!.id);

        Navigator.pushNamedAndRemoveUntil(
          context,
          PagePath.getPoint,
          (Route<dynamic> route) => false,
        );

        print("Hasil scan: $qrCodeData");
      }

    });
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
      controller!.toggleFlash();
    });
  }

  void toggleCamera() {
    setState(() {
      currentCameraFacing = currentCameraFacing == CameraFacing.back
          ? CameraFacing.front
          : CameraFacing.back;
      controller!.flipCamera();
    });
  }

  @override
  void dispose() async {
    super.dispose();
    controller?.dispose();
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
                      child: QRView(
                            key: qrKey,
                            cameraFacing: currentCameraFacing,
                            onQRViewCreated: onQRViewCreated,
                            overlay: QrScannerOverlayShape(
                              borderColor: Colors.transparent,
                              borderRadius: 0,
                              borderLength: 0,
                              borderWidth: 0,
                              cutOutSize: 450,
                            ),
                          )
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
                          toggleFlash();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Flash Mode"),
                                content: isFlashOn
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
                          toggleCamera();
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
