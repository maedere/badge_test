part of 'assign_badge_bloc.dart';

@immutable
abstract class AssignBadgeState {}

class AssignBadgeInitial extends AssignBadgeState {
   final List<String> userNames;

  AssignBadgeInitial(this.userNames);
}
class AssignBadgeLoading extends AssignBadgeState {}
class AssignBadgeShowList extends AssignBadgeState {
  final List<String> selectedBadges;
  final String userName;

  AssignBadgeShowList(this.selectedBadges, this.userName);
}
class AssignBadgeFail extends AssignBadgeState {
  final String errorMessage;

  AssignBadgeFail(this.errorMessage);
}
class AssignBadgeStatistics extends AssignBadgeState{
  final List<Map> assignments;
  final String userName;

  AssignBadgeStatistics(this.userName,this.assignments);
}
