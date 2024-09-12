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

class Home extends StatelessWidget {
  final VoidCallback onFullScreenImage;

  const Home({super.key, required this.onFullScreenImage});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the image size dynamically based on platform (example)
    final double imageSize = screenWidth > SizeConstants.size600
        ? SizeConstants.size100
        : SizeConstants.size50; // Web vs Mobile

    setStatusBar();
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

  PreferredSizeWidget buildCustomAppBar(double imageSize) {
    return PreferredSize(
      preferredSize: Size.fromHeight(SizeConstants.size100),
      child: Padding(
        padding: EdgeInsets.only(
            left: SizeConstants.size30,
            right: SizeConstants.size30,
            top: SizeConstants.size14,
            bottom: SizeConstants.size2),
        child: SizedBox(
          height: SizeConstants.size80, // Set the height of the row
          width: double.infinity, // Full width
          child: Row(
            children: [
              Image.asset(
                'assets/images/ic_pixabay_logo.png',
                height: imageSize, // Dynamic height and width based on platform
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

class SearchField extends ConsumerWidget {
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
