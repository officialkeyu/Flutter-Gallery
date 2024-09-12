// widgets/full_screen_image.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tech_test/base/color_constants.dart';
import '../models/image_data.dart';




class FullScreenImage extends StatelessWidget {
  final ImageData image;

  const FullScreenImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.white,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: Hero(
            tag: image.id,
            child: CachedNetworkImage(imageUrl: image.url),
          ),
        ),
      ),
    );
  }
}
