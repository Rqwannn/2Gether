import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0, left: 0, child: Image.asset(Config().loginRec2)),
          Positioned(
              top: 0, left: 0, child: Image.asset(Config().loginRec3)),
     
              
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  "Pilih Rolemu!",
                  style: TextStyle(
                    fontSize: Config().titleTextSize,
                    fontWeight: FontWeight.bold,
                    color: Config().greenColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Turn useless into useful",
                  style: TextStyle(
                    fontSize: Config().smallTextSize,
                    fontWeight: FontWeight.w500,
                    color: Config().greenColor,
                  ),
                ),
                SizedBox(height: Config().distancePerValue - 10),

                GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        PagePath.home,
                        (Route<dynamic> route) => false,
                      );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue + 50),
                    child: Card(
                      color: Config().lightGrayColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), 
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person, // Ikon pengguna
                              size: Config().titleTextSize,
                              color: Config().greenColor, 
                            ),
                            SizedBox(width: 5),
                            Text(
                              'Users',
                              style: TextStyle(
                                fontSize: Config().mediumTextSize,
                                fontWeight: FontWeight.w500,
                                color: Config().greenColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: Config().distancePerValue),

                GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue + 50),
                    child: Card(
                      color: Config().lightGrayColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0), 
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.settings, // Ikon pengguna
                              size: Config().titleTextSize,
                              color: Config().greenColor, 
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Host',
                              style: TextStyle(
                                fontSize: Config().mediumTextSize,
                                fontWeight: FontWeight.w500,
                                color: Config().greenColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
       
              ],
            ),
          ),

          Positioned(
            bottom: 0, 
            left: 0,
            right: 0, 
            child: Image.asset(
              Config().role,
              width: MediaQuery.of(context).size.width,
              height: 200,
            )
          ),
        ],
      ),
    );
  }
}