import 'dart:developer';

import 'package:badge_test_1/core/error/failure.dart';
import 'package:badge_test_1/features/auth/domain/entities/person.dart';
import 'package:badge_test_1/features/auth/domain/repositories/auth_repository.dart';
import 'package:badge_test_1/features/badge/domain/entities/badge_assignment.dart';
import 'package:badge_test_1/features/badge/domain/repositories/assign_badge_repository.dart';
import 'package:badge_test_1/utils/const.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

class AssignBadgeRepositoryImpl implements AssignBadgeRepository {
  final Box box;
  final Box personBox;

  AssignBadgeRepositoryImpl(this.box, this.personBox);

  @override
  Future<Either<Failure, bool>> assignBadge(
      BadgeAssignment badgeAssignment) async {
    try {
      bool contains = false;
      for (int i = 0; i < box.length; i++) {
        BadgeAssignment current = box.getAt(i) as BadgeAssignment;
        if (current.holder == badgeAssignment.holder &&
            current.allocator == badgeAssignment.allocator &&
            current.badge == badgeAssignment.badge) {
          contains = true;
          box.deleteAt(i);
          break;
        }
      }
      if (!contains) await box.add(badgeAssignment);
      return Right(true);
    } catch (e) {
      return Left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, List<BadgeAssignment>>> getBadgeAssignments() async {
    try {
      List<BadgeAssignment> badgeAssignments = [];
      for (int i = 0; i < box.length; i++) {
        badgeAssignments.add(box.getAt(i));
      }
      return (Right(badgeAssignments));
    } catch (e) {
      return Left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getUsers() async {
    List<String> keys = [];
    for (final k in personBox.keys) {
      keys.add(k.toString());
    }
    try {
      return (Right(keys));
    } catch (e) {
      return Left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getUserBadges(
      String allocator, String userName) async {
    try {
      List<BadgeAssignment> badgeAssignments = [];
      for (int i = 0; i < box.length; i++) {
        if ((box.getAt(i) as BadgeAssignment).allocator == allocator) {
          badgeAssignments.add(box.getAt(i));
        }
      }
      List<BadgeAssignment> personBadgeAssignments = badgeAssignments
          .where((element) => element.holder == userName)
          .toList();
      List<String> result = [];
      for (final p in personBadgeAssignments) {
        result.add(p.badge);
      }
      return (Right(result));
    } catch (e) {
      return Left(DBFailure());
    }
  }

  @override
  Future<Either<Failure, List<Map>>> getUserStatistics(String userName) async {
    try {
      List<BadgeAssignment> badgeAssignments = [];
      for (int i = 0; i < box.length; i++) {
        if ((box.getAt(i) as BadgeAssignment).holder == userName) {
          badgeAssignments.add(box.getAt(i));
        }
      }
      List<Map> statistic = [];
      for (final badge in Const.badges) {
        int count = 0;
        for (final badgeAssignment in badgeAssignments) {
          if (badgeAssignment.badge == badge) count++;
        }
        statistic.add({badge: count});
      }

      return (Right(statistic));
    } catch (e) {
      return Left(DBFailure());
    }
  }
}
