import 'dart:developer';

import 'package:badge_test_1/core/error/failure.dart';
import 'package:badge_test_1/features/auth/domain/entities/person.dart';
import 'package:badge_test_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:badge_test_1/utils/const.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

class AuthRepositoryImpl implements AuthRepository {
  //final NumberTriviaRemoteDataSource remoteDataSource;
  //final NumberTriviaLocalDataSource localDataSource;

  final Box box;

  AuthRepositoryImpl(this.box);
  @override
  Either<Failure, bool> isPersonFromDB(Person person) {
    try {
      String? password = box.get(person.name);
      if (password != null) {
        return Right(person.password == password);
      } else {
        return const Right(false);
      }
    } catch (e) {
      return Left(DBFailure());
    }
  }

  @override
  Either<Failure, bool> savePersonInDB(Person person) {
    try {
//      var personTable = Hive.box(Const.personTable);
      String? password = box.get(person.name);
      if (password != null) {
        return const Right(false);
      } else {
        box.put(person.name, person.password);
        return const Right(true);
      }
    } catch (e) {
      return Left(DBFailure());
    }
  }
}
