import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';

class ProfileHostPage extends StatefulWidget {
  const ProfileHostPage({super.key});

  @override
  State<ProfileHostPage> createState() => _ProfileHostPageState();
}

class _ProfileHostPageState extends State<ProfileHostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0, 
            left: 0, 
            right: 0, 
            child: Image.asset(Config().hostRectangle)
          ),
          
          Positioned(
            top: Config().distancePerValue + 30, 
            left: 20, 
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Selamat Pagi!",
                  maxLines: 1,
                  style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: Config().titleTextSize,
                      fontWeight: FontWeight.w500,
                      color: Config().greenColor),
                ),

                const SizedBox(height: 6),

                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return Text(
                      "${state.userEntity!.username}!",
                      maxLines: 1,
                      style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: Config().smallToMediumTextSize,
                          fontWeight: FontWeight.w500,
                          color: Config().greenColor),
                    );
                  },
                ),
              ],
            )
          ),

          Positioned(
            top: 270,
            left: 20,
            right: 20,
            bottom: 20,
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Container(
                    padding: EdgeInsets.all(Config().distancePerValue),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Config().grayColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "1",
                              style: TextStyle(
                                fontSize: Config().smallTextSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            "Bogor",
                            style: TextStyle(
                              fontSize: Config().smallToMediumTextSize,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Config().distancePerValue),

                  Container(
                    padding: EdgeInsets.all(Config().distancePerValue),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Config().grayColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "2",
                              style: TextStyle(
                                fontSize: Config().smallTextSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            "Jakarta",
                            style: TextStyle(
                              fontSize: Config().smallToMediumTextSize,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Config().distancePerValue),
                  
                  Container(
                    padding: EdgeInsets.all(Config().distancePerValue),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Config().grayColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "3",
                              style: TextStyle(
                                fontSize: Config().smallTextSize,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            "Depok",
                            style: TextStyle(
                              fontSize: Config().smallToMediumTextSize,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            )
          ),

          Positioned(
            top: 165,
            left: 20,
            right: 20,
            child: Container(
              padding: EdgeInsets.all(Config().distancePerValue),
              decoration: BoxDecoration(
                color:  Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300]!,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Text(
                    "QR Anda",
                    style: TextStyle(
                      fontSize: Config().mediumTextSize,
                      color: Colors.black
                    ),
                  ),
                  
                  Text(
                    "3",
                    style: TextStyle(
                      fontSize: Config().smallToMediumTextSize,
                      color: Colors.black
                    ),
                  ),


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}