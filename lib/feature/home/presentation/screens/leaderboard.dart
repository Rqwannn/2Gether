import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/home/presentation/widgets/leaderboard_card.dart';
import 'package:twogether/feature/home/skeleton/leaderboard_card_skeleton.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;

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

          StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('users')
                .orderBy('poin', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: List.generate(
                    10,
                    (index) => Padding(
                      padding: EdgeInsets.only(bottom: Config().distancePerText),
                      child: const LeaderboardCardSkeleton(),
                    ),
                  ),
                );
              }

              List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;

              return Column(
                children: List.generate(
                  data.length,
                  (index) {
                    QueryDocumentSnapshot<Object?> leaderboard = data[index];

                    return Padding(
                      padding: EdgeInsets.only(bottom: Config().distancePerText),
                      child: LeaderboardCard(
                        id: leaderboard['id'],
                        imageUrl: leaderboard['photoURL'],
                        name: leaderboard['username'],
                        score: leaderboard['poin'],
                        standing: index + 1,
                      ),
                    );
                  },
                ),
              );

            },
          ),

        ],
      ),
    );
  }
}