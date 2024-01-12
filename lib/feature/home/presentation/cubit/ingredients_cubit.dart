import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'ingredients_state.dart';

class IngredientsCubit extends HydratedCubit<IngredientsState> {
  IngredientsCubit() : super(const IngredientsState(ingredients: []));

  Future<void> save({
    required List<String> ingredients,
  }) async {
    emit(state.copyWith(ingredients: ingredients));
  }

  @override
  IngredientsState? fromJson(Map<String, dynamic> json) {
    try {
      return IngredientsState(
        ingredients: json['ingredients'],
      );
    } catch (e) {
      throw UnimplementedError();
    }
  }

  @override
  Map<String, dynamic>? toJson(IngredientsState state) {
    try {
      return <String, dynamic>{
        'ingredients': state.ingredients,
      };
    } catch (e) {
      throw UnimplementedError();
    }
  }
}
