import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:qr_image_generator/qr_code_image.dart';
import 'package:twogether/config/config.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({
    super.key,
    required this.address,
    required this.position 
  });

  final String address;
  final LatLng position;

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  // Future<Uint8List?> generateQRCodeImage() async {
  //   final dataToEncode = widget.address; // Ganti dengan data yang ingin di-encode

  //   try {
  //     final ui.Image qrCodeImage = await QrCodeImage(
  //       data: dataToEncode,
  //       size: 200,
  //     ).toImage(200);

  //     ByteData byteData = await qrCodeImage.toByteData(format: ui.ImageByteFormat.png);
  //     return byteData.buffer.asUint8List();
  //   } catch (e) {
  //     print("Error generating QR code image: $e");
  //     return null;
  //   }
  // }

  // Future<void> saveImage(Uint8List byteDataList) async {
  //   final appDir = await getApplicationDocumentsDirectory();
  //   final filePath = '${appDir.path}/my_qr_code.png';

  //   await File(filePath).writeAsBytes(byteDataList);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Config().greenColor),
        ),
        title: Text(
          "Pilih Lokasi",
          style: TextStyle(
            fontSize: Config().mediumTextSize,
            fontWeight: FontWeight.bold,
            color: Config().greenColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Config().startGradientColorCard,
                    Config().endGradientColorCard
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                Config().qrCodeIcon,
                width: 220,
                height: 220,
              )
            ),

            // FutureBuilder<Uint8List?>(
            //   future: generateQRCodeImage(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.done) {
            //       if (snapshot.hasError || snapshot.data == null) {
            //         return Text('Error generating QR code image');
            //       } else {
            //         return Image.memory(snapshot.data!);
            //       }
            //     } else {
            //       return CircularProgressIndicator();
            //     }
            //   },
            // ),

            SizedBox(height: Config().distancePerValue + 30),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue + 30),
              child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Config().startGradientColorCard,
                    Config().endGradientColorCard
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(7),
              ),
              child: ElevatedButton(
                  onPressed: () {
                    // final byteDataList = await generateQRCodeImage();
                    // if (byteDataList != null) {
                    //   await saveImage(byteDataList);
                    //   // TODO: Show a confirmation message or navigate to a success screen
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    disabledForegroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ).copyWith(
                    fixedSize: MaterialStateProperty.all(
                      const Size.fromHeight(100),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Unduh QR',
                      style: TextStyle(
                        color: Config().greenColor,
                        fontSize: Config().smallToMediumTextSize,
                      ),
                    ),
                  )
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}