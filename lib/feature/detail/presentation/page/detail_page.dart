import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/feature.dart';

class DetailPageArgs {
  const DetailPageArgs({
    required this.id,
    required this.image,
    required this.title,
  });

  final String id;
  final String image;
  final String title;
}

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    required this.args,
  });

  final DetailPageArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Config().greenColor),
        ),
        title: Text(
          args.title,
          style: TextStyle(
            fontSize: Config().mediumTextSize,
            fontWeight: FontWeight.bold,
            color: Config().greenColor,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomImage(
              image: args.image,
              // "https://firebasestorage.googleapis.com/v0/b/twogether-app-project.appspot.com/o/receip%2Fcardboard_mask.png?alt=media&token=f34cae4d-c10c-43d1-845a-16176d9bf0b9",
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How to create',
                    style: TextStyle(
                      fontSize: Config().mediumTextSize,
                      fontWeight: FontWeight.bold,
                      color: Config().greenColor,
                    ),
                  ),
                  SizedBox(height: Config().distancePerValue),
                  Text(
                    '1. Cut out the bottom third of a 2-liter bottle.\n2. Paint the bottle white or the color of your choice.\n3. Fill the bottle with seeds and soil.',
                    style: TextStyle(
                      fontSize: Config().smallToMediumTextSize,
                      fontWeight: FontWeight.w400,
                      color: Config().greenColor,
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pushNamed(context, PagePath.unggah),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Config().greenColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        child: Text(
                          "Selesai",
                          style: TextStyle(
                            fontSize: Config().smallTextSize,
                            fontWeight: FontWeight.w500,
                            color: Config().whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.image,
  });

  final String image;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.network(
          image,
          width: double.infinity,
          height: 356,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 36,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          alignment: Alignment.center,
          child: Container(
            width: 32,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[400],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}
