import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';

class PilihLokasiPage extends StatefulWidget {
  const PilihLokasiPage({super.key});

  @override
  State<PilihLokasiPage> createState() => _PilihLokasiPageState();
}

class _PilihLokasiPageState extends State<PilihLokasiPage> {
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            SizedBox(height: Config().distancePerValue),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black),
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.transparent, // Jika ingin transparent
                  ),
                ),


                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Config().grayColor,
                          width: 2,
                        ),
                      ),
                      hintText: 'Lokasi Terkini',
                    ),
                  ),
                ),

              ],
            ),

             SizedBox(height: Config().distancePerText),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  size: 25,
                  Icons.location_pin
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Config().grayColor,
                          width: 2,
                        ),
                      ),
                      hintText: 'Lokasi Anda',
                    ),
                  ),
                ),

              ],
            ),

            SizedBox(height: Config().distancePerValue + 20),

            Image.asset(
              Config().pilihLokasiImg,
              width: MediaQuery.of(context).size.width,
            ),

            SizedBox(height: Config().distancePerValue + 20),

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
                      const Size.fromHeight(80),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Hasilkan QR',
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