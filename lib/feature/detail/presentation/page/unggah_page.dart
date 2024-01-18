import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';

class UnggahPage extends StatefulWidget {
  const UnggahPage({super.key});

  @override
  State<UnggahPage> createState() => _UnggahPageState();
}

class _UnggahPageState extends State<UnggahPage> {
  bool isCardVisible = false;

  Future<void> openGallery() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print("Path: ${image.path}");
      Navigator.pushNamed(context, PagePath.upload);
    }
  }

  Future<void> openFileManager() async {
    final result = await FilePicker.platform.pickFiles();

    if (result != null) {
      print("Path: ${result.files.single.path}");
      Navigator.pushNamed(context, PagePath.upload);
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

              SizedBox(height: Config().distancePerValue + 50),

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

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Config().distancePerValue),
                child: Image.asset(
                  Config().unggahPageImg,
                  width: MediaQuery.of(context).size.width,
                ),
              ),

              SizedBox(height: Config().distancePerValue),

              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isCardVisible = !isCardVisible;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Config().greenColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    child: Text(
                      "Unggah",
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
                      InkWell(
                        onTap: () {
                          openGallery();
                        },
                        child: Icon(Icons.photo, size: 50, color: Config().greenColor),
                      ),
                      InkWell(
                        onTap: () {
                          openFileManager();
                        },
                        child: Icon(Icons.insert_drive_file, size: 50, color: Config().greenColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      )
    );
  }
}