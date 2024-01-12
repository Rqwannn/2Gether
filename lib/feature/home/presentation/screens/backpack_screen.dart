import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/feature.dart';
import 'package:twogether/feature/home/skeleton/skeleton.dart';
import 'package:twogether/locator.dart';

class BackpackScreen extends StatelessWidget {
  const BackpackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                      'SCAN NOW',
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
            "Your Backpack",
            style: TextStyle(
                fontSize: Config().smallToMediumTextSize,
                fontWeight: FontWeight.bold,
                color: Config().greenColor),
          ),
          SizedBox(height: Config().distancePerValue - 10),
          StreamBuilder<QuerySnapshot>(
            stream: db
                .collection('backpack')
                .where("user", isEqualTo: sl<UserCubit>().state.userEntity!.id)
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

              // Collect all 'title' fields into a list
              List<String> titles =
                  data.map((doc) => doc['title'] as String).toList();

              // Save the list to IngredientsCubit
              sl<IngredientsCubit>().save(ingredients: titles);

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
                        level: "${trending['count']} Items",
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
