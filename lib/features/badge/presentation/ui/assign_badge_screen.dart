import 'package:badge_test_1/features/badge/domain/repositories/assign_badge_repository.dart';
import 'package:badge_test_1/features/badge/presentation/bloc/assign_badge_bloc.dart';
import 'package:badge_test_1/utils/const.dart';
import 'package:badge_test_1/utils/strings.dart';
import 'package:badge_test_1/utils/widgets/badge/badge_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/widgets/badge/badge_assignment_rate.dart';
import '../../../../utils/widgets/badge/person_item_widget.dart';
import '../../../auth/domain/entities/person.dart';

class AssignBadgeScreen extends StatelessWidget {
  const AssignBadgeScreen({Key? key, required this.currentUser})
      : super(key: key);
  final Person currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider<AssignBadgeBloc>(
            create: (context) =>
                AssignBadgeBloc(context.read<AssignBadgeRepository>()),
            child: Builder(builder: (context) {
              SchedulerBinding.instance.addPostFrameCallback((_) {
                context
                    .read<AssignBadgeBloc>()
                    .add(AssignBadgeStarted(currentUser));
              });

              return _buildBody(context);
            }) //_buildBody(context),
            ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title:  Text(currentUser.name == Const.adminName
            ? Strings.badgeStatistic
            : Strings.badgeAssignment),
        centerTitle: true,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.exit_to_app),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<AssignBadgeBloc, AssignBadgeState>(
            builder: (context, state) {
          return Column(
            children: context
                .read<AssignBadgeBloc>()
                .users
                .map((e) => PersonItemWidget(
                      name: e,
                      onTap: () {
                        if (currentUser.name == Const.adminName) {
                          context
                              .read<AssignBadgeBloc>()
                              .add(AssignBadgeGetUserStatistics(e));
                        } else {
                          context
                              .read<AssignBadgeBloc>()
                              .add(AssignBadgeSelectUser(currentUser.name, e));
                        }
                      },
                    ))
                .toList(),
          );
        }),
        _buildBadgeListPart(context)
      ],
    );
  }

  Widget _buildBadgeListPart(BuildContext context) {
    return BlocBuilder<AssignBadgeBloc, AssignBadgeState>(
        builder: (context, state) {
      if (state is AssignBadgeShowList) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          padding: EdgeInsets.all(12.r),
          margin: EdgeInsets.all(12.r),
          child: Column(
            children: [
              Text(state.userName),
              Divider(
                color: Colors.green,
              ),
              Column(
                children: Const.badges
                    .map((e) => BadgeWidget(
                          title: e,
                          isSelected: state.selectedBadges.contains(e),
                          onTap: () {
                            context.read<AssignBadgeBloc>().add(
                                AssignBadgeSelectBadge(
                                    badge: e,
                                    allocator: currentUser.name,
                                    holder: state.userName));
                          },
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      } else if (state is AssignBadgeStatistics) {
        return Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          padding: EdgeInsets.all(12.r),
          margin: EdgeInsets.all(12.r),
          child: Column(
            children: [
              Text(state.userName),
              Divider(
                color: Colors.green,
              ),
              Column(
                children: state.assignments
                    .map((e) => BadgeAssignmentRate(
                          badge: e.keys.first,
                          count: e.values.first.toString(),
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      } else
        return SizedBox();
    });
  }
}
