import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';
import 'package:twogether/locator.dart';

class FormInstansiPage extends StatefulWidget {
  const FormInstansiPage({super.key});

  @override
  State<FormInstansiPage> createState() => _FormInstansiPageState();
}

class _FormInstansiPageState extends State<FormInstansiPage> {
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController namaInstansiController = TextEditingController();

  Future<void> saveToFirestore() async {
    try {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            title: Text("Loading"),
            content: Text("Loading"),
          );
        },
      );

      CollectionReference selectionHostCollection = FirebaseFirestore.instance.collection('host');

      String namaInstansi = namaInstansiController.text;

      await selectionHostCollection.add({
        'kontak_person': namaLengkapController.text,
        'email': emailController.text,
        'nama_instansi': namaInstansi,
        'id_account': sl<UserCubit>().state.userEntity!.id,
      });


      AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: 'Data berhasil disimpan!',
          body: 'Akun anda berhasil di simpan dengan Nama Instansi: $namaInstansi',
        ),
      );

    } catch (e) {
       AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 10,
          channelKey: 'basic_channel',
          actionType: ActionType.Default,
          title: 'Data gagal disimpan!',
          body: 'Tolong hubungin customer service kami jika terjadi masalah ini',
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: Config().distancePerValue + 60),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Buat Tempat Sampah!",
                style: TextStyle(
                  fontSize: Config().titleTextSize,
                  fontWeight: FontWeight.bold,
                  color: Config().greenColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: Config().distancePerValue + 10),

            TextField(
              controller: namaLengkapController,
              decoration: InputDecoration(
                labelText: 'Nama Lengkap',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Config().grayColor,
                    width: 2,
                  ),
                ),
                hintText: 'Masukkan Nama Lengkap',
              ),
            ),

             SizedBox(height: Config().distancePerValue + 10),


             TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Config().grayColor,
                    width: 2,
                  ),
                ),
                hintText: 'Masukkan Email',
              ),
            ),

            SizedBox(height: Config().distancePerValue + 10),

            TextField(
              controller: namaInstansiController,
              decoration: InputDecoration(
                labelText: 'Nama Instansi',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Config().grayColor,
                    width: 2,
                  ),
                ),
                hintText: 'Masukkan Nama Instansi',
              ),
            ),

            SizedBox(height: Config().distancePerValue),

            Center(
              child: GestureDetector(
                onTap: () {
                  saveToFirestore();

                  Navigator.pushNamed(
                    context,
                    PagePath.host,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Config().greenColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Text(
                    "Masuk",
                    style: TextStyle(
                      fontSize: Config().smallToMediumTextSize,
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
    );
  }
}