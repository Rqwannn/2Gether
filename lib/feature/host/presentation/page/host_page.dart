import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/auth/auth.dart';
import 'package:twogether/feature/host/presentation/screen/profile.dart';
import 'package:twogether/feature/host/presentation/screen/tipe_sampah.dart';
import 'package:twogether/locator.dart';

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
          if (index == 2) {
            context.read<GoogleAuthCubit>().googleSignOut();
          }

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
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Log Out",
          ),
        ],
      ),
    );
  }
}