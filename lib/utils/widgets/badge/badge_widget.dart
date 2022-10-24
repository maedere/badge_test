import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  const BadgeWidget(
      {Key? key,
      required this.title,
      required this.isSelected,
      required this.onTap})
      : super(key: key);
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Container(
        child: Row(
          children: [
            Text(title),
            Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank)
          ],
        ),
      ),
    );
  }
}
