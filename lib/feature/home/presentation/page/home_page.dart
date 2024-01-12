import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twogether/config/config.dart';

import 'package:twogether/feature/feature.dart';
import 'package:twogether/feature/home/presentation/screens/leaderboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.index = 0
  });

  final int index;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  int index = 0;

  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController();

    return Scaffold(
      body: SafeArea(
        top: index != 3,
        child: PageView(
          controller: pageController,
          onPageChanged: (i) => setState(() {
            index = i;
          }),
          children: const [
            DashboardScreen(),
            BackpackScreen(),
            ReceipScreen(),
            LeaderboardPage(),
            ProfileScreen(),
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
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.backpack),
            label: "Backpack",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.language),
            label: "World",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_events),
            label: "Leaderboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profil",
          ),
        ],
      ),
    );
  }
}

class DashBoardAppBar extends StatelessWidget {
  const DashBoardAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.only(left: 8),
          width: 240,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hai ${state.userEntity!.username}!",
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: Config().titleTextSize,
                    fontWeight: FontWeight.w500,
                    color: Config().greenColor),
              ),
              Text(
                "Let’s make something creative!",
                style: TextStyle(
                    fontSize: Config().smallTextSize,
                    fontWeight: FontWeight.normal,
                    color: Config().greenColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
