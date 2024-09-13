import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart'; // Import for kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tech_test/base/color_constants.dart';
import 'package:tech_test/base/font_style.dart';

import '../apis/image_provider.dart';
import '../base/size_constants.dart';
import '../models/image_data.dart';
import '../ui/full_screen_image.dart';

/// A [StateProvider] family to manage the hover state for each image item by its ID.
final hoverProvider = StateProvider.family<bool, int>((ref, id) => false);

/// A widget that displays a grid of images with hover effects and dynamic loading.
class ImageGrid extends ConsumerWidget {
  /// List of images to be displayed in the grid.
  final List<ImageData> images;

  /// Controller to handle scrolling within the grid view.
  final ScrollController _scrollController = ScrollController();

  ImageGrid({super.key, required this.images});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Attach a listener to detect scrolling and fetch new images when necessary.
    _scrollController.addListener(() => _onScroll(ref));

    final crossAxisCount = (MediaQuery.of(context).size.width / 200)
        .floor(); // Dynamically determine number of columns based on screen width.

    return MasonryGridView.count(
      crossAxisCount:
          (MediaQuery.of(context).size.width < 600) ? 2 : crossAxisCount,
      // Show 2 columns for mobile devices
      itemCount: images.length,
      controller: _scrollController,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      itemBuilder: (context, index) {
        final image = images[index];
        return HoverImageItem(image: image);
      },
    );
  }

  /// Handles scrolling to fetch more images when the user reaches the bottom of the grid.
  void _onScroll(WidgetRef ref) {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      ref.read(imageProvider.notifier).fetchNextPage();
    }
  }
}

/// A widget that displays an individual image item with hover effects.
class HoverImageItem extends ConsumerWidget {
  final ImageData image;

  /// Creates a [HoverImageItem] widget for a given [ImageData].
  const HoverImageItem({super.key, required this.image});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Observe the hover state for this specific image using its ID.
    final isHovered = kIsWeb
        ? ref.watch(hoverProvider(image.id)) // Hover on web
        : true; // Always visible on mobile (iOS/Android)

    return GestureDetector(
      onTap: () => showFullScreenImage(context, image),
      child: kIsWeb
          ? MouseRegion(
              onEnter: (_) =>
                  ref.read(hoverProvider(image.id).notifier).state = true,
              onExit: (_) =>
                  ref.read(hoverProvider(image.id).notifier).state = false,
              child: _buildStack(context, isHovered, image),
            )
          : _buildStack(context, isHovered, image), // No hover on mobile
    );
  }

  /// Builds the stack for the image and its hover effects.
  Widget _buildStack(BuildContext context, bool isHovered, ImageData image) {
    return Stack(
      children: [
        Hero(
          tag: image.id,
          child: CachedNetworkImage(imageUrl: image.url),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            opacity: isHovered ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: SizeConstants.size8,
                  horizontal: SizeConstants.size16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black54],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: SizeConstants.size16,
                          ),
                          SizedBox(width: SizeConstants.size4),
                          Text(
                            '${image.likes}', // Like count dynamically
                            style: FontStyle.openSansSemiBoldTextColor_14
                                .copyWith(color: ColorConstants.white),
                          ),
                        ],
                      ),
                      SizedBox(width: SizeConstants.size16),
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Colors.white,
                            size: SizeConstants.size16,
                          ),
                          SizedBox(width: SizeConstants.size4),
                          Text(
                            '${image.views}', // View count dynamically
                            style: FontStyle.openSansSemiBoldTextColor_14
                                .copyWith(color: ColorConstants.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: AnimatedOpacity(
            opacity: isHovered ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, Colors.black54],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Text(
                image.title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showFullScreenImage(BuildContext context, ImageData image) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 300),
        // Fast opening animation
        reverseTransitionDuration: const Duration(milliseconds: 300),
        // Fast closing animation
        pageBuilder: (_, __, ___) => FullScreenImage(image: image),
        transitionsBuilder: (_, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}
