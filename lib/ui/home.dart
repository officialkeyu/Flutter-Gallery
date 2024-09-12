import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_test/base/size_constants.dart';
import 'package:tech_test/base/utils.dart';
import '../apis/image_provider.dart';
import '../base/color_constants.dart';
import '../base/font_style.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/image_grid.dart';

/// Represents the Home screen of the application, displaying a grid of images.
class Home extends StatelessWidget {
  /// Callback to navigate to the full-screen image view.
  final VoidCallback onFullScreenImage;

  /// Constructor for the [Home] widget.
  const Home({super.key, required this.onFullScreenImage});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the image size dynamically based on the screen width.
    final double imageSize = screenWidth > SizeConstants.size600
        ? SizeConstants.size100
        : SizeConstants.size50;

    setStatusBar(); // Set status bar style
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: buildCustomAppBar(imageSize),
        body: Consumer(
          builder: (context, ref, child) {
            final images = ref.watch(imageProvider);
            return ImageGrid(images: images);
          },
        ),
      ),
    );
  }

  /// Builds a custom app bar with a dynamic image size.
  PreferredSizeWidget buildCustomAppBar(double imageSize) {
    return PreferredSize(
      preferredSize: Size.fromHeight(SizeConstants.size100),
      child: Padding(
        padding: EdgeInsets.only(
          left: SizeConstants.size30,
          right: SizeConstants.size30,
          top: SizeConstants.size14,
          bottom: SizeConstants.size2,
        ),
        child: SizedBox(
          height: SizeConstants.size80,
          width: double.infinity,
          child: Row(
            children: [
              Image.asset(
                'assets/images/ic_pixabay_logo.png',
                height: imageSize,
                width: imageSize,
              ),
              SizedBox(width: SizeConstants.size10),
              const Expanded(
                child: SearchField(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A custom search field widget that handles search input for Pixabay.
class SearchField extends ConsumerWidget {
  /// Constructor for the [SearchField] widget.
  const SearchField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Timer? debounceTimer;

    return CustomTextField(
      cursorColor: ColorConstants.black,
      textInputAction: TextInputAction.search,
      controller: TextEditingController(),
      textInputType: TextInputType.text,
      valueHintTextStyle: FontStyle.openSansSemiBoldTextColor_16.copyWith(
        color: ColorConstants.darkGrey,
      ),
      valueTextStyle: FontStyle.openSansSemiBoldTextColor_16,
      hint: 'Search Pixabay',
      focusNode: FocusNode(),
      boxColor: ColorConstants.grey,
      prefixIcon: const Icon(Icons.search),
      prefixIconColor: ColorConstants.darkGrey,
      onChanged: (value) {
        if (debounceTimer?.isActive ?? false) debounceTimer!.cancel();
        debounceTimer = Timer(
          const Duration(milliseconds: 500),
              () {
            ref.read(searchQueryProvider.notifier).state = value;
            ref.read(imageProvider.notifier).reset();
          },
        );
      },
    );
  }
}
