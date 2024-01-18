import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/common/common.dart';

class LeaderboardCard extends StatefulWidget {
  const LeaderboardCard({
    super.key,
    required this.id, 
    required this.name, 
    required this.score, 
    required this.imageUrl,
    required this.standing
  });

  final String name;
  final String id;
  final int score;
  final int standing;
  final String imageUrl;

  @override
  State<LeaderboardCard> createState() => _LeaderboardCardState();
}

class _LeaderboardCardState extends State<LeaderboardCard> {

  standing(int standing) {
    if (standing == 1) {
      return Icon(
        Icons.emoji_events,
        color: Config().gold,
        size: Config().titleTextSize,
      );
    } else if (standing == 2) {
      return Icon(
        Icons.emoji_events,
        color: Config().silver,
        size: Config().titleTextSize,
      );
    } else if (standing == 3) {
      return Icon(
        Icons.emoji_events,
        color: Config().bronze,
        size: Config().titleTextSize,
      );
    } else {
      return Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            widget.standing.toString(),
            style: TextStyle(
              fontSize: Config().smallTextSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.only(
                top: Config().distancePerText, 
                bottom: Config().distancePerText, 
                right: Config().distancePerText, 
                left: 6
              ),
              decoration: BoxDecoration(
                color: widget.id == state.userEntity!.id ? Config().leaderboardActiveColor : Colors.white,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  
                  Row(
                    children: [

                      standing(widget.standing),

                      SizedBox(width: Config().distancePerText + 6),

                      ClipOval(
                        child: Image.network(
                            widget.imageUrl,
                            width: 45,
                            height: 45,
                          ),
                      ),
                      
                      SizedBox(width: Config().distancePerText),

                      Container(
                        width: 140,
                        child: Text(
                        widget.name,
                          style: const TextStyle(
                            fontSize: 14,
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
                      color: Colors.black
                    ),
                  ),


                ],
              ),
            );
          },
        ),
      ],
    );
  }
}