import 'dart:async';

import 'package:badge_test_1/features/badge/domain/entities/badge_assignment.dart';
import 'package:badge_test_1/utils/strings.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../auth/domain/entities/person.dart';
import '../../domain/repositories/assign_badge_repository.dart';

part 'assign_badge_event.dart';

part 'assign_badge_state.dart';

class AssignBadgeBloc extends Bloc<AssignBadgeEvent, AssignBadgeState> {
  final AssignBadgeRepository assignBadgeRepository;
  List<String> users = [];

  AssignBadgeBloc(this.assignBadgeRepository) : super(AssignBadgeInitial([])) {
    on<AssignBadgeEvent>((event, emit) async {
      if (event is AssignBadgeStarted) {
        var result = await assignBadgeRepository.getUsers();
        result.fold((l) => emit(AssignBadgeFail(Strings.errorInParseDB)), (r) {
          users =
              r.where((element) => element != event.currentUser.name).toList();
          emit(AssignBadgeInitial(r
              .where((element) => element != event.currentUser.name)
              .toList()));
        });
      }

      if (event is AssignBadgeSelectUser) {
        var result = await assignBadgeRepository.getUserBadges(
            event.allocator, event.userName);
        result.fold((l) => emit(AssignBadgeFail(Strings.errorInParseDB)), (r) {
          emit(AssignBadgeShowList(r, event.userName));
        });
      } else if (event is AssignBadgeSelectBadge) {
        await assignBadgeRepository.assignBadge(BadgeAssignment(
            allocator: event.allocator,
            holder: event.holder,
            badge: event.badge));
        var result = await assignBadgeRepository.getUserBadges(
            event.allocator, event.holder);
        result.fold((l) => emit(AssignBadgeFail(Strings.errorInParseDB)), (r) {
          emit(AssignBadgeShowList(r, event.holder));
        });
      } else if (event is AssignBadgeGetUserStatistics) {
        var result =
            await assignBadgeRepository.getUserStatistics(event.userName);
        result.fold((l) => emit(AssignBadgeFail(Strings.errorInParseDB)), (r) {
          emit(AssignBadgeStatistics(event.userName,r));
        });
      }
    });
  }
}
