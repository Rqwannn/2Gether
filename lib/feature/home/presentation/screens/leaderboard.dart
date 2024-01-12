import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/home/presentation/widgets/leaderboard_card.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(left: Config().distancePerValue, right: Config().distancePerValue, top: Config().distancePerValue + 50, bottom: Config().distancePerValue ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Leaderboard",
            style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: Config().titleTextSize,
              fontWeight: FontWeight.bold,
              color: Config().greenColor,
            ),
          ),

          SizedBox(height: Config().distancePerValue),

          LeaderboardCard(
            name: "Adam Abdurahman", 
            score: 5075, 
            imageUrl: Config().defaultUser
          ),

          SizedBox(height: Config().distancePerText),
          
          LeaderboardCard(
            name: "Achmad Ardani", 
            score: 5075, 
            imageUrl: Config().defaultUser
          )

        ],
      ),
    );
  }
}