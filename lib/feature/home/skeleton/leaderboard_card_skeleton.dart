import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:twogether/config/config.dart';

class LeaderboardCardSkeleton extends StatelessWidget {
  const LeaderboardCardSkeleton(
    {
      super.key
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      width:  MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
        top: Config().distancePerText, 
        bottom: Config().distancePerText, 
        right: Config().distancePerText, 
        left: 12
      ),
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
              Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade500,
                child: Icon(
                  Icons.emoji_events,
                  color: Config().gold,
                  size: Config().titleTextSize,
                ),
              ),
              SizedBox(width: Config().distancePerText),
              Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey.shade500,
                child: ClipOval(
                  child: Container(
                    width: 40,
                    height: 40,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(width: Config().distancePerText),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey.shade400,
                    highlightColor: Colors.grey.shade500,
                    child: Container(
                      width: 130,
                      height: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Shimmer.fromColors(
            baseColor: Colors.grey.shade400,
            highlightColor: Colors.grey.shade500,
            child: Container(
              width: 50,
              height: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
