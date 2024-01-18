import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';

class GetPointPage extends StatefulWidget {
  const GetPointPage({super.key});

  @override
  State<GetPointPage> createState() => _GetPointPageState();
}

class _GetPointPageState extends State<GetPointPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(
        context, 
        PagePath.home,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Config().blueOceanColor,
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
          Positioned(
              top: 80, 
              left: 0, 
              right: 0,
              child: Text(
                "Selamat!",
                style: TextStyle(
                  fontSize: Config().titleTextSize,
                  fontWeight: FontWeight.bold,
                  color: Config().greenColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),


            Positioned(
              bottom: 120, 
              left: 0, 
              right: 0,
              child: Column(
                children: [
                  Text(
                    "Kamu",
                    style: TextStyle(
                      fontSize: Config().titleTextSize,
                      fontWeight: FontWeight.bold,
                      color: Config().greenColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Mendapatkan",
                    style: TextStyle(
                      fontSize: Config().titleTextSize,
                      fontWeight: FontWeight.bold,
                      color: Config().greenColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "10 Point",
                    style: TextStyle(
                      fontSize: Config().titleTextSize,
                      fontWeight: FontWeight.bold,
                      color: Config().orangeColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            ),
          
        ],
      ),
    );
  }
}