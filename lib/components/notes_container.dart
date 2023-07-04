import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_notes/components/circular_container.dart';
import 'package:my_notes/ui_helper/ui_helper.dart';

class NotesContainer extends StatelessWidget {
  String title;
  String description;
  VoidCallback deleteCallback;
  NotesContainer({required this.title, required this.description, required this.deleteCallback});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Stack(
      children: [
        ClipPath(
          clipper: MyClipper(),
          child: Container(
            width: size.width, height: size.height*0.25,
            margin: EdgeInsets.symmetric(horizontal: size.width*0.05, vertical: size.height*0.017),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: gradient(),
              borderRadius: BorderRadius.circular(35)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: mTextStyle20(), maxLines: 1),
                SizedBox(height: size.height*0.02,),
                Text(description, style: mTextStyle12(), maxLines: 3),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width*0.07, vertical: size.width*0.07),
              child: InkWell(
                onTap: deleteCallback,
                  child: CircularContainer(icon: Icon(Icons.delete, size: 21, color: Colors.white,), radius: size.width*0.057,)),
            )),
      ],
    );
  }
  LinearGradient gradient(){
    var gradientColor = const [
      LinearGradient(colors: [Color(0xffff9a9e), Color(0xfffad0c4)],
      begin: Alignment.bottomCenter, end: Alignment.topCenter),

      LinearGradient(colors: [Color(0xffa18cd1), Color(0xfffbc2eb)],
          begin: Alignment.bottomCenter, end: Alignment.topCenter),

      LinearGradient(colors: [Color(0xffffecd2), Color(0xfffcb69f)],
          begin: Alignment.bottomCenter, end: Alignment.topCenter),

      LinearGradient(colors: [Color(0xfff6d365), Color(0xfffda085)],
          begin: Alignment.bottomCenter, end: Alignment.topCenter),

      LinearGradient(colors: [Color(0xff84fab0), Color(0xff8fd3f4)],
          begin: Alignment.bottomCenter, end: Alignment.topCenter),

      LinearGradient(colors: [Color(0xffd4fc79), Color(0xff96e6a1)],
          begin: Alignment.bottomCenter, end: Alignment.topCenter),
    ];
    int num = Random().nextInt(gradientColor.length);
    return gradientColor[num];
  }
}

class MyClipper extends CustomClipper<Path>{
  @override
  getClip(Size size) {
    var mPath = Path();
    mPath.lineTo(size.width*0.5, 0);
    mPath.cubicTo(size.width, size.height*0.1, size.width*0.5, size.height*0.4, size.width, size.height*0.35);
    mPath.lineTo(size.width, size.height);
    mPath.lineTo(0, size.height);
    mPath.lineTo(0, 0);
    return mPath;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

}
