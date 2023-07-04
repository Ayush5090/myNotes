import 'package:flutter/material.dart';

class AppBtn extends StatelessWidget {
  final String childText;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final VoidCallback onPressed;

  const AppBtn({
    required this.childText,
    required this.onPressed,
    this.backgroundColor,
    this.width, this.height
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ElevatedButton(
      child: Text(childText, style: TextStyle(color: Colors.white, letterSpacing: 1)),
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? Colors.pink,
        fixedSize: Size(width ?? size.width*0.9, height ?? size.height*0.07)
      ),
      onPressed: onPressed,
    );
  }
}
