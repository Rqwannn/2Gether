import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';

class TipeSampahPage extends StatefulWidget {
  const TipeSampahPage({super.key});

  @override
  State<TipeSampahPage> createState() => _TipeSampahPageState();
}

class _TipeSampahPageState extends State<TipeSampahPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: Config().distancePerValue + 60),

            Text(
              "Pilih Jenis Sampah",
              style: TextStyle(
                fontSize: Config().titleTextSize,
                fontWeight: FontWeight.bold,
                color: Config().greenColor,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: Config().distancePerValue + 30),

            InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  PagePath.pilihLokasi,
                );
              },
              child: Container(
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
                width: MediaQuery.of(context).size.width,
                height: 110,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Organik',
                      style: TextStyle(
                        fontSize: Config().mediumTextSize,
                        fontWeight: FontWeight.w500,
                        color: Config().greenColor,
                      ),
                    ),
                  ],
                ))
              ),

              SizedBox(height: Config().distancePerValue),

              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PagePath.pilihLokasi,
                  );
                },
                child: Container(
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
                  width: MediaQuery.of(context).size.width,
                  height: 110,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Anorganik',
                        style: TextStyle(
                          fontSize: Config().mediumTextSize,
                          fontWeight: FontWeight.w500,
                          color: Config().greenColor,
                        ),
                      ),
                    ],
                  ))
                ),
              
              SizedBox(height: Config().distancePerValue),

              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    PagePath.pilihLokasi,
                  );
                },
                child: Container(
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
                        'B3',
                        style: TextStyle(
                          fontSize: Config().mediumTextSize,
                          fontWeight: FontWeight.w500,
                          color: Config().greenColor,
                        ),
                      ),
                    ],
                  ))
                ),
          ],
        ),
      )
    );
  }
}