import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:twogether/config/config.dart';
import 'package:twogether/feature/feature.dart';
import 'package:twogether/locator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: -20, left: 0, child: Image.asset(Config().loginRec2)),
          Positioned(
              top: -20, left: 0, child: Image.asset(Config().loginRec3)),

          Positioned(
              top: 80,
              bottom: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                Config().loginComponent,
                width: 300,
              )),
              
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ShaderMask(
                //   shaderCallback: (Rect bounds) {
                //     return LinearGradient(
                //       colors: [
                //         Config().startGradientColor,
                //         Config().endGradientColor
                //       ],
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //       tileMode: TileMode.clamp,
                //     ).createShader(bounds);
                //   },
                //   child: Text(
                //     "Selamat Datang!",
                //     style: TextStyle(
                //       fontSize: Config().titleTextSize,
                //       fontWeight: FontWeight.bold,
                //       color:
                //           Colors.white,
                //     ),
                //   ),
                // ),

                Text(
                  "Selamat Datang!",
                  style: TextStyle(
                    fontSize: Config().titleTextSize,
                    fontWeight: FontWeight.bold,
                    color: Config().greenColor,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Mari Kontribusi Untuk Bumi Kita",
                  style: TextStyle(
                    fontSize: Config().smallTextSize,
                    fontWeight: FontWeight.w500,
                    color: Config().greenColor,
                  ),
                ),
                SizedBox(height: Config().distancePerValue - 10),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                        top: Config().distancePerValue,
                        bottom: Config().distancePerValue),
                    child: Image.asset(
                      Config().loginLogo,
                      height: 250,
                    ),
                  ),
                ),
                BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
                  listener: (context, state) {
                    if (state is GoogleAuthLoading) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Loading"),
                            content: Text("Loading"),
                          );
                        },
                      );
                    } else {
                      Navigator.popUntil(
                        context,
                        ModalRoute.withName(PagePath.login),
                      );
                    }

                    if (state is GoogleAuthSuccess) {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        PagePath.role,
                        (Route<dynamic> route) => false,
                      );
                      // Navigator.pushNamedAndRemoveUntil(
                      //   context,
                      //   PagePath.home,
                      //   (Route<dynamic> route) => false,
                      // );
                    } else if (state is GoogleAuthError) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text("Failed"),
                            content: Text("Failed"),
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      onPressed: () =>
                          context.read<GoogleAuthCubit>().signIn(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Config().orangeColor,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            Config().googleIcon,
                            height: 30,
                          ),
                          const SizedBox(width: 20),
                          const Text(
                            'Daftar Dengan Google',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          // Positioned(
          //   top: 75,
          //   left: 20,
          //   child: Column(
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Text(
          //         "Hi There!",
          //         style: TextStyle(
          //           fontSize: Config().titleTextSize,
          //           fontWeight: FontWeight.bold,
          //           color: Config().greenColor,
          //         ),
          //       ),
          //       Text(
          //         "Contribute to our Earth",
          //         style: TextStyle(
          //           fontSize: Config().smallTextSize,
          //           color: Config().greenColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          Positioned(
              bottom: 0, left: 0, child: Image.asset(Config().loginRec1)),
        ],
      ),
    );
  }
}
