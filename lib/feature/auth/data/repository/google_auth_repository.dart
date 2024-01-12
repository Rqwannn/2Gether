import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:twogether/core/core.dart';
import 'package:twogether/feature/feature.dart';

class GoogleAuthRepository with BaseRepository {
  final GoogleAuthDataSource _remoteDataSource;

  GoogleAuthRepository(this._remoteDataSource);

  Future<Either<Failure, UserCredential>> signIn() async {
    try {
      final UserCredential response = await _remoteDataSource.signIn();

      return Right(response);
    } on FirebaseAuthException catch (e) {
      return Left(Failure(message: e.message.toString()));
    }
  }

  Future<void> googleSignOut() async {
    await _remoteDataSource.googleSignOut();
  }
}
