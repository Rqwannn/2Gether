import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({
    super.key,
    required this.logo,
    required this.title,
    required this.content,
    required this.contentTitle,
    required this.contentLogo,
    this.logoWidth = 60,
  });

  final String title;
  final String content;
  final double logoWidth;
  final String logo;
  final String contentTitle;
  final String contentLogo;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        
        SizedBox(height: Config().distancePerValue + 50),

        Image.asset(
          logo,
          height: logoWidth,
        ),

        Text(
          title,
          style: TextStyle(
            fontSize: Config().mediumTextSize,
            fontWeight: FontWeight.bold,
            color: Config().greenColor,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue),
          child: Image.asset(
            contentLogo,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue),
          child: Text(
            contentTitle,
            style: TextStyle(
              fontSize: Config().mediumTextSize,
              fontWeight: FontWeight.w700,
              color: Config().greenColor,
            ),
            textAlign: TextAlign.center,
          ),
        ),

        SizedBox(height: Config().distancePerText),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue),
          child: Text(
            content,
            style: TextStyle(
              fontSize: Config().smallTextSize,
              fontWeight: FontWeight.w500,
              color: Config().grayColor,
            ),
            textAlign: TextAlign.center,
          ),
        )

      ],
    );
  }
}