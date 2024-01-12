part of 'ingredients_cubit.dart';

class IngredientsState extends Equatable {
  final List<String> ingredients;

  const IngredientsState({
    required this.ingredients,
  });

  @override
  List<Object> get props => [ingredients];

  IngredientsState copyWith({
    List<String>? ingredients,
  }) {
    return IngredientsState(
      ingredients: ingredients ?? this.ingredients,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'ingredients': ingredients,
    };
  }

  factory IngredientsState.fromMap(Map<String, dynamic> map) {
    return IngredientsState(
      ingredients: List<String>.from(map['ingredients']),
    );
  }

  String toJson() => json.encode(toMap());

  factory IngredientsState.fromJson(String source) =>
      IngredientsState.fromMap(json.decode(source));

  @override
  String toString() => 'IngredientsState(ingredients: $ingredients)';
}
