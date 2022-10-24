import 'package:badge_test_1/features/auth/domain/entities/person.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class AuthRepository {

  Either<Failure, bool> savePersonInDB(Person person);
 Either<Failure, bool> isPersonFromDB(Person person);
}