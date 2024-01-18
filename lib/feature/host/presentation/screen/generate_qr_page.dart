import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    print(widget.address);
    print(widget.position);
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
              height: 110,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'QR',
                    style: TextStyle(
                      fontSize: Config().mediumTextSize,
                      fontWeight: FontWeight.w500,
                      color: Config().greenColor,
                    ),
                  ),
                ],
              )
            ),

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