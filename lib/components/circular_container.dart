import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  Icon icon;
  double? radius;
  CircularContainer({required this.icon, this.radius});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return CircleAvatar(
      radius: radius ?? size.width*0.07,
      backgroundColor: Colors.black,
      child: icon,
    );
  }
}
