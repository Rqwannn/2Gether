import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';
import 'package:twogether/locator.dart';
import 'package:twogether/service/notification_controller.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({super.key});

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  bool isCardVisible = false;

  Future<void> tambahPoin(String userId) async {
    try {
      DocumentReference userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      DocumentSnapshot userSnapshot = await userRef.get();

      // Mengambil nilai poin saat ini
      int poinSaatIni = userSnapshot['poin'] ?? 0;
      String username = userSnapshot['username'];

      int poinBaru = poinSaatIni + 10;

      await userRef.update({'poin': poinBaru});

      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: 'Upload Berhasil!',
          body: 'Berhasil menambahkan 10 poin ke pengguna dengan Username: $username',
        ),
      );

      Navigator.pushNamed(context, PagePath.getPoint);

    } catch (e) {
      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: 'Upload Gagal!',
          body: 'Terdapat Kesalah Pada Sistem Mohon Untuk Menghubungi Customer Service',
        ),
      );
    }
  }

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
      body: Stack(
        children: [
          Column(
            children: <Widget>[

              SizedBox(height: Config().distancePerValue + 30),

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

              SizedBox(height: Config().distancePerValue + 10 ),

              SingleChildScrollView(
                child: Container(
                  height: 250,
                  // padding: EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 0,
                    runSpacing: 0,
                    children: List.generate(6, (index) {
                      
                      if(index != 0){
                        return Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.all(Config().distancePerText),
                              width: 88,
                              height: 88,
                              decoration: BoxDecoration(
                                color: Config().semiGrayColor,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),

                            Positioned(
                              top: 4,
                              right: 4,
                              child: Icon(
                                Icons.add_circle,
                                size: 25,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      }

                      return InkWell(
                        onTap: () {
                          setState(() {
                            isCardVisible = !isCardVisible;
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.all(Config().distancePerText),
                          width: 88,
                          height: 88,
                          decoration: BoxDecoration(
                            color: Config().semiGrayColor,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add_circle,
                              size: 25,
                              color: Config().whiteColor,
                            )
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),

              SizedBox(height: Config().distancePerValue + 30),

              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    tambahPoin(sl<UserCubit>().state.userEntity!.id);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Config().greenColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text(
                      "Upload",
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

          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            bottom: isCardVisible ? 0 : -150,
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: isCardVisible ? 1.0 : 0.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding:  EdgeInsets.all(Config().distancePerValue),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.photo, size: 50, color: Config().greenColor),
                      Icon(Icons.insert_drive_file, size: 50, color: Config().greenColor),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}