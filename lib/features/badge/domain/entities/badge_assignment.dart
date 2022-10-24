import 'dart:io';

import 'package:hive/hive.dart';

part 'badge_assignment.g.dart';

@HiveType(typeId: 2)
class BadgeAssignment {
  BadgeAssignment(
      {required this.allocator, required this.holder, required this.badge});

  @HiveField(0)
  String allocator;
  @HiveField(1)
  String holder;
  @HiveField(2)
  String badge;
}
