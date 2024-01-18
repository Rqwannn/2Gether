import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/feature.dart';
import 'package:twogether/feature/home/skeleton/skeleton.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return Text(
                "Hai ${state.userEntity!.username}!",
                maxLines: 1,
                style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: Config().mediumTextSize,
                    fontWeight: FontWeight.w500,
                    color: Config().greenColor),
              );
            },
          ),
          Text(
            "Let’s make something creative!",
            style: TextStyle(
                fontSize: Config().smallTextSize,
                fontWeight: FontWeight.normal,
                color: Config().greenColor),
          ),
          SizedBox(height: Config().distancePerValue),
          InkWell(
            onTap: () {
              Navigator.pushNamed(
                context,
                PagePath.scan,
                // (Route<dynamic> route) => true,
              );
            },
            child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Config().startGradientColorCard,
                      Config().endGradientColorCard
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Config().endGradientColorIcon,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          Config().plusIcon,
                          width: 25,
                        )),
                    Text(
                      'Ambil Foto',
                      style: TextStyle(
                        fontSize: Config().mediumTextSize,
                        fontWeight: FontWeight.bold,
                        color: Config().greenColor,
                      ),
                    ),
                  ],
                )),
          ),
          SizedBox(height: Config().distancePerValue),
          Text(
            "Trending",
            style: TextStyle(
                fontSize: Config().smallToMediumTextSize,
                fontWeight: FontWeight.bold,
                color: Config().greenColor),
          ),
          SizedBox(height: Config().distancePerValue - 10),
          StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('trending')
                // .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Wrap(
                  children: [

                    FractionallySizedBox(
                      widthFactor: 0.5,
                      child: TrendingCardSkeleton()
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.5,
                      child: TrendingCardSkeleton()
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.5,
                      child: TrendingCardSkeleton()
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.5,
                      child: TrendingCardSkeleton()
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.5,
                      child: TrendingCardSkeleton()
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.5,
                      child: TrendingCardSkeleton()
                    ),
                    
                  ],
                );
              }

              List<QueryDocumentSnapshot<Object?>> data = snapshot.data!.docs;

              return Wrap(
                children: List.generate(
                  data.length,
                  (index) {
                    QueryDocumentSnapshot<Object?> trending = data[index];

                    return FractionallySizedBox(
                      widthFactor: 0.5,
                      child: TrendingCard(
                        image: trending['image'],
                        title: trending['title'],
                        level: trending['level'],
                        onTap: () => print("Test"),
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
