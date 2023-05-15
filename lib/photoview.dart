import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class photoview extends StatefulWidget {
  String? proimage;

  photoview(this.proimage);

  @override
  State<photoview> createState() => _photoviewState();
}

class _photoviewState extends State<photoview> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Align(alignment: Alignment.center,
          child: Container(
      height: size.height * 0.5,
      width: size.width * 0.7,
      child: PhotoView(
            minScale: PhotoViewComputedScale.contained * 1,
            backgroundDecoration: BoxDecoration(color: Colors.white),
            imageProvider: NetworkImage(
                "https://chetansheladiya.000webhostapp.com/apicalling/"
                "${widget.proimage}")),
    ),
        ));
  }
}
