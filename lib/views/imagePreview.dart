import 'dart:io';
import 'dart:ui' as ui show Image;


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_tag/constants/colors.dart';
import 'package:image_tag/constants/fonts.dart';
import 'package:zoom_widget/zoom_widget.dart';

class ImagePreview extends StatelessWidget {
  String url;
  ImagePreview({Key? key, required this.url}) : super(key: key);

  Future<ui.Image> _loadImage(File file) async{
    final data =await file.readAsBytes();
    return await decodeImageFromList(data);
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(physics: NeverScrollableScrollPhysics(), padding: EdgeInsets.symmetric(vertical: 100), children: [

        Center(child: Text("Preview Image",style: fontMontserrat(fontWeight: FontWeight.normal,fontSize: 20),)),
        Center(child: Text("You can zoom in and out the picture",style: fontMontserrat(fontWeight: FontWeight.normal,fontSize: 13),)),
        SizedBox(height: 20,),

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
             /* Positioned(
                top: 40,
                left: 200,
                child: GestureDetector(
                  onTap: (){
                    print("okay");
                    _loadImage(url as File);
                  },
                  child: CustomPaint(
                    painter: Rectangle(image:  , faces: []),
                  ),
                ),
              )*/
            ],
          ),
        ),
      ]),
    );
  }
}

class Rectangle extends CustomPainter {
  bool? isFilled;
  final ui.Image image;
  final List<Rect>faces;
  Rectangle({this.isFilled,required this.image,required this.faces});

  @override
  void paint(Canvas canvas, Size size) {
    
    canvas.drawImage(image, Offset.zero, Paint());
    for(var i = 0; i< faces.length;i++){
      canvas.drawRect(faces[i], Paint());
    }
    /*Paint paint = Paint();
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
    canvas.drawRect(rect, paint);*/
  }

  @override
  bool shouldRepaint(Rectangle oldDelegate) =>  image !=oldDelegate.image || faces !=oldDelegate.faces;
}
