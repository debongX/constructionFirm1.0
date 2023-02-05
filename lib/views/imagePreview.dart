import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_tag/constants/colors.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ImagePreview extends StatelessWidget {
  String url;
  ImagePreview({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(physics: NeverScrollableScrollPhysics(), padding: EdgeInsets.symmetric(vertical: 20), children: [
        SizedBox(
          height: Get.height / 2,
          width: Get.width / 2,
          child: Stack(
            children: [
              Zoom(
                initTotalZoomOut: true,
                backgroundColor: kWhiteColor,
                child:  CachedNetworkImage(
                  imageUrl: url,
                  height: 570,
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                top: 40,
                left: 200,
                child: GestureDetector(
                  onTap: (){
                    print("sds");
                  },
                  child: CustomPaint(
                    painter: Rectangle(),
                  ),
                ),
              )
            ],
          ),
        ),
      ]),
    );
  }
}

class Rectangle extends CustomPainter {
  bool? isFilled;
  Rectangle({this.isFilled});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue;
    if (isFilled != null) {
      paint.style = PaintingStyle.fill;
    } else {
      paint.style = PaintingStyle.stroke;
    }
    paint.strokeCap = StrokeCap.round;
    paint.strokeJoin = StrokeJoin.round;
    paint.strokeWidth = 15;
    Offset offset = Offset(size.width * 0.1, size.height);

    Rect rect = Rect.fromCenter(center: offset, width: 10, height: 15);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant Rectangle oldDelegate) {
    return false;
  }
}

/*

),*/
