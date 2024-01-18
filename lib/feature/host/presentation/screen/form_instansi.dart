import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';

class FormInstansiPage extends StatefulWidget {
  const FormInstansiPage({super.key});

  @override
  State<FormInstansiPage> createState() => _FormInstansiPageState();
}

class _FormInstansiPageState extends State<FormInstansiPage> {
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

            Container(
              child: Text(
                "Nama Lengkap",
                style: TextStyle(
                  fontSize: Config().smallToMediumTextSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),

            const SizedBox(height: 5),

            TextField(
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

             Container(
              child: Text(
                "Email",
                style: TextStyle(
                  fontSize: Config().smallToMediumTextSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),

            const SizedBox(height: 5),

             TextField(
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

            Container(
              child: Text(
                "Nama Instansi",
                style: TextStyle(
                  fontSize: Config().smallToMediumTextSize,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),

            const SizedBox(height: 5),

            TextField(
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
                onTap: () => Navigator.pushNamed(context, PagePath.host),
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