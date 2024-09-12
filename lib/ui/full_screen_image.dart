// widgets/full_screen_image.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_test/base/color_constants.dart';

import '../models/image_data.dart';

class FullScreenImage extends StatelessWidget {
  final ImageData image;

  const FullScreenImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: GestureDetector(
        onVerticalDragEnd: (_) => Navigator.pop(context),
        // Detect vertical swipe
        onHorizontalDragEnd: (_) => Navigator.pop(context),
        // Detect horizontal swipe
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
