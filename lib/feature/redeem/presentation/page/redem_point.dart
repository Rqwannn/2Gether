import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/feature.dart';

class RedemPage extends StatefulWidget {
  const RedemPage({super.key});

  @override
  State<RedemPage> createState() => _RedemPageState();
}

class _RedemPageState extends State<RedemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Config().greenColor),
        ),
        title: Text(
          "Reedem Points",
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue),
          child: Column(
            children: [
              SizedBox(height: Config().distancePerValue),

              Image.asset(
                Config().coupon1,
                width: MediaQuery.of(context).size.width,
              ),

              SizedBox(height: Config().distancePerValue),

              InkWell(
                onTap: () => Navigator.pushNamed(context, PagePath.detailRedeem),
                child: Image.asset(
                  Config().coupon2,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              SizedBox(height: Config().distancePerValue),

              Image.asset(
                Config().coupon3,
                width: MediaQuery.of(context).size.width,
              ),

            
            ],
          ),
        )
      )
    );
  }
}