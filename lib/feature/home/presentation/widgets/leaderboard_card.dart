import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';

class LeaderboardCard extends StatefulWidget {
  const LeaderboardCard({
    super.key,
    required this.name, 
    required this.score, 
    required this.imageUrl
  });

  final String name;
  final int score;
  final String imageUrl;

  @override
  State<LeaderboardCard> createState() => _LeaderboardCardState();
}

class _LeaderboardCardState extends State<LeaderboardCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Config().distancePerText),
      decoration: BoxDecoration(
        color: Colors.white,
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
        children: [
          
          Row(
            children: [
              Icon(
                Icons.emoji_events,
                color: Config().gold,
                size: Config().titleTextSize,
              ),

              const SizedBox(width: 8),

              ClipOval(
                child: Image.asset(
                    widget.imageUrl,
                    width: 50,
                    height: 50,
                  ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 130,
                child: Text(
                widget.name,
                  style: TextStyle(
                    fontSize: Config().smallToMediumTextSize,
                    fontWeight: FontWeight.w500,
                    color: Colors.black
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
          
          Text(
            widget.score.toString(),
            style: TextStyle(
              fontSize: Config().smallToMediumTextSize,
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),
          ),

        ],
      ),
    );
  }
}