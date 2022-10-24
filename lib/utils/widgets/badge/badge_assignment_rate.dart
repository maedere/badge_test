import 'package:flutter/cupertino.dart';

class BadgeAssignmentRate extends StatelessWidget {
  const BadgeAssignmentRate(
      {Key? key, required this.badge, required this.count})
      : super(key: key);
  final String badge;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(badge), Text(count)],
      ),
    );
  }
}
