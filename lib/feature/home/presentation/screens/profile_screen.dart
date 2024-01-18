import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/feature.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Positioned(top: 0, left: 0, child: Image.asset(Config().loginRec2)),
        Positioned(top: 0, left: 0, child: Image.asset(Config().loginRec3)),
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: state.userEntity!.photoURL != null
                                  ? Image.network(
                                      '${state.userEntity!.photoURL}',
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      Config().avatar,
                                      width: 100,
                                      height: 100,
                                    ),
                            ),
                            SizedBox(height: Config().distancePerText),
                            Text(
                              "${state.userEntity!.username}",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: Config().titleTextSize,
                                fontWeight: FontWeight.bold,
                                color: Config().greenColor,
                              ),
                            ),
                            Text(
                              "${state.userEntity!.email}",
                              style: TextStyle(
                                fontSize: Config().smallTextSize,
                                color: Config().greenColor,
                              ),
                            ),

                            SizedBox(height: Config().distancePerValue),

                            Container(
                              padding: EdgeInsets.all(Config().distancePerValue),
                              decoration: BoxDecoration(
                                color:  Config().GreenDarkColor,
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
                                      fontSize: Config().smallTextSize,
                                      color: Colors.black
                                    ),
                                  ),
                                  
                                  Text(
                                    "3",
                                    style: TextStyle(
                                      fontSize: Config().smallTextSize,
                                      color: Colors.black
                                    ),
                                  ),


                                ],
                              ),
                            ),

                            SizedBox(height: Config().distancePerValue),

                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue + 30),
                              child: DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Config().startGradientColorCard,
                                    Config().endGradientColorCard
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: ElevatedButton(
                                  onPressed: () {
                                    
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    disabledForegroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ).copyWith(
                                    fixedSize: MaterialStateProperty.all(
                                      const Size.fromHeight(50),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Redeem Point',
                                      style: TextStyle(
                                        color: Config().greenColor,
                                        fontSize: Config().smallToMediumTextSize,
                                      ),
                                    ),
                                  )
                                ),
                              ),
                            ),

                          ],
                        ),
                      )),
                ),
              ],
            );
          },
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
                ModalRoute.withName(PagePath.home),
              );
            }

            if (state is GoogleAuthSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                PagePath.login,
                (Route<dynamic> route) => false,
              );
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
            return Positioned(
                left: 20,
                right: 20,
                bottom: 20,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Config().startGradientColorBtn,
                        Config().endGradientColorBtn
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ElevatedButton(
                      onPressed: () =>
                          context.read<GoogleAuthCubit>().googleSignOut(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        disabledForegroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Log out',
                          style: TextStyle(
                            color: Config().greenColor,
                            fontSize: Config().smallToMediumTextSize,
                          ),
                        ),
                      )),
                ));
          },
        ),
      ],
    );
  }
}
