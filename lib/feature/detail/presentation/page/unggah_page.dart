import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';

class UnggahPage extends StatefulWidget {
  const UnggahPage({super.key});

  @override
  State<UnggahPage> createState() => _UnggahPageState();
}

class _UnggahPageState extends State<UnggahPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Config().greenColor),
        ),
        title: Text(
          "Unggah Foto",
          style: TextStyle(
            fontSize: Config().mediumTextSize,
            fontWeight: FontWeight.bold,
            color: Config().greenColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: <Widget>[

          SizedBox(height: Config().distancePerValue + 50),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              "Unggah Hasil Karyamu!",
              style: TextStyle(
                fontSize: Config().titleTextSize,
                fontWeight: FontWeight.bold,
                color: Config().greenColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue),
            child: Image.asset(
              Config().unggahPageImg,
              width: MediaQuery.of(context).size.width,
            ),
          ),

          SizedBox(height: Config().distancePerValue),

          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              // onTap: () => Navigator.pushNamed(context, PagePath.detail),
              child: Container(
                decoration: BoxDecoration(
                    color: Config().greenColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                child: Text(
                  "Unggah",
                  style: TextStyle(
                    fontSize: Config().smallTextSize,
                    fontWeight: FontWeight.w500,
                    color: Config().whiteColor,
                  ),
                ),
              ),
            ),
          )

        ],
      ),
    );
  }
}