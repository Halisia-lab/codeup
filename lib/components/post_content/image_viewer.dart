import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  final imagePath;
  const ImageViewer(this.imagePath);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        2.0,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, bottom: 20.0, left: 5.0, right: 5.0),
        child: customNetworkImage(imagePath, BoxFit.cover),
      ),
    );
  }

  static Image customNetworkImage(String path, BoxFit boxFit) {
  return Image(image: NetworkImage(path), fit: boxFit,);
}
}