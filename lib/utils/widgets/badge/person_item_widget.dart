import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonItemWidget extends StatelessWidget {
  PersonItemWidget({Key? key, required this.name, required this.onTap})
      : super(key: key);
  final String name;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            border: Border.all(color: Colors.black)),
        margin: EdgeInsets.all(12.r),
        padding: EdgeInsets.all(8.r),
        child: Row(
          children: [
            Text(name),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
}
