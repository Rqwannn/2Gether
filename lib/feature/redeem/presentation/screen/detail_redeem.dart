import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';

class DetailRedeem extends StatefulWidget {
  const DetailRedeem({super.key});

  @override
  State<DetailRedeem> createState() => _DetailRedeemState();
}

class _DetailRedeemState extends State<DetailRedeem> {
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
                Config().detailCoupon,
                width: MediaQuery.of(context).size.width,
              ),
            
            ],
          ),
        )
      ),
    );
  }
}