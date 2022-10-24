part of 'assign_badge_bloc.dart';

@immutable
abstract class AssignBadgeEvent {}
class AssignBadgeStarted extends AssignBadgeEvent {
final Person currentUser;

  AssignBadgeStarted(this.currentUser);
}
class AssignBadgeSelectUser extends AssignBadgeEvent {
  final String userName;
  final String allocator;

  AssignBadgeSelectUser(this.allocator,this.userName);

}
class AssignBadgeSelectBadge extends AssignBadgeEvent {
  final String badge;
  final String holder;
  final String allocator;

  AssignBadgeSelectBadge({required this.badge,required this.allocator,required this.holder});

}
class AssignBadgeGetUserStatistics extends AssignBadgeEvent {
  final String userName;
  AssignBadgeGetUserStatistics(this.userName);

}
