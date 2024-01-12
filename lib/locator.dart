import 'package:get_it/get_it.dart';

import 'package:twogether/core/core.dart';
import 'package:twogether/feature/feature.dart';

final sl = GetIt.instance;

Future<void> init() async {
  /// User
  sl.registerLazySingleton(() => UserCubit());

  /// Ingredients
  sl.registerLazySingleton(() => IngredientsCubit());

  // /// Challenge
  // sl.registerFactory(() => ChallengeDateTimeCubit());
  // sl.registerFactory(() => ChallengeImagePickerCubit());

  /// Firebase Auth With Google
  sl.registerLazySingleton(() => GoogleAuthDataSource());
  sl.registerLazySingleton(() => GoogleAuthRepository(sl()));
  sl.registerFactory(() => GoogleAuthCubit(sl()));

  // /// Dio
  // sl.registerLazySingleton(() => DioClient.dioInit());

  // /// IQ Air
  // sl.registerLazySingleton(() => IQAirRepository(sl()));
  // sl.registerLazySingleton(() => IQAirRemoteDataSource(sl()));
  // sl.registerFactory(() => GetIqairCubit(sl()));

  // /// Geolocator
  // sl.registerFactory(() => GeolocatorCubit());
}
