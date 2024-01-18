import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/host/presentation/screen/profile.dart';
import 'package:twogether/feature/host/presentation/screen/tipe_sampah.dart';

class HostPage extends StatefulWidget {
  const HostPage({super.key});

  @override
  State<HostPage> createState() => _HostPageState();
}

class _HostPageState extends State<HostPage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (i) => setState(() {
            index = i;
          }),
          children: const [
            TipeSampahPage(),
            ProfileHostPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (index) {
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
        unselectedItemColor: Config().grayColor,
        fixedColor: Config().greenColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: "Tipe Sampah",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}