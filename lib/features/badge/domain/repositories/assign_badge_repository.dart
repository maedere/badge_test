import 'package:badge_test_1/features/auth/domain/entities/person.dart';
import 'package:badge_test_1/features/badge/domain/entities/badge_assignment.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';

abstract class AssignBadgeRepository {
  Future<Either<Failure, bool>> assignBadge(BadgeAssignment badgeAssignment);

  Future<Either<Failure, List<BadgeAssignment>>> getBadgeAssignments();

  Future<Either<Failure, List<String>>> getUserBadges(
      String allocator, String userName);

  Future<Either<Failure, List<String>>> getUsers();

  Future<Either<Failure, List<Map>>> getUserStatistics(String userName);
}
