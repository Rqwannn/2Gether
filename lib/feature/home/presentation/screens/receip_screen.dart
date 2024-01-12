import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:twogether/config/config.dart';
import 'package:twogether/feature/feature.dart';
import 'package:twogether/feature/home/skeleton/skeleton.dart';
import 'package:twogether/locator.dart';

class ReceipScreen extends StatelessWidget {
  const ReceipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore db = FirebaseFirestore.instance;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Choose What\nWould You Make!',
            style: TextStyle(
              fontSize: Config().bigTextSize,
              fontWeight: FontWeight.bold,
              color: Config().greenColor,
            ),
          ),
          SizedBox(height: Config().distancePerValue),
          sl<IngredientsCubit>().state.ingredients.isNotEmpty
              ? StreamBuilder<QuerySnapshot>(
                  stream: db
                      .collection('trending')
                      .where('ingredients',
                          arrayContainsAny:
                              sl<IngredientsCubit>().state.ingredients)
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

                    List<QueryDocumentSnapshot<Object?>> data =
                        snapshot.data!.docs;

                    return Wrap(
                      children: List.generate(
                        data.length,
                        (index) {
                          QueryDocumentSnapshot<Object?> trending = data[index];

                          // Only show item that have match ingredients

                          return FractionallySizedBox(
                            widthFactor: 0.5,
                            child: TrendingCard(
                              image: trending['image'],
                              title: trending['title'],
                              level: trending['level'],
                              onTap: () => Navigator.pushNamed(
                                context,
                                PagePath.detail,
                                arguments: DetailPageArgs(
                                  id: "id",
                                  image: trending['image'],
                                  title: trending['title'],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              : Container(
                  margin: EdgeInsets.only(top: 36),
                  alignment: Alignment.center,
                  child: Text(
                    'Your backpack is empty',
                    style: TextStyle(
                      fontSize: Config().smallToMediumTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
