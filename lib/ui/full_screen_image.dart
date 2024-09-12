// widgets/full_screen_image.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tech_test/base/color_constants.dart';
import '../models/image_data.dart';

/// A widget to display an image in full screen mode with interactive swipe and tap gestures.
class FullScreenImage extends StatelessWidget {
  /// The image data to display in full screen.
  final ImageData image;

  /// Creates a [FullScreenImage] widget.
  const FullScreenImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.black,
      body: GestureDetector(
        onVerticalDragEnd: (_) => Navigator.pop(context), // Detect vertical swipe
        onHorizontalDragEnd: (_) => Navigator.pop(context), // Detect horizontal swipe
        onTap: () => Navigator.pop(context), // Detect tap
        child: Center(
          child: Hero(
            tag: image.id, // Unique tag for hero animation
            child: CachedNetworkImage(imageUrl: image.url),
          ),
        ),
      ),
    );
  }
}
