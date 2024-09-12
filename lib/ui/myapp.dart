import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_test/base/size_constants.dart';

import '../base/color_constants.dart';
import '../base/font_style.dart';
import '../apis/image_provider.dart';
import '../widgets/custom_textfield.dart';
import 'image_grid.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: buildCustomAppBar(),
        body: Consumer(
          builder: (context, ref, child) {
            final images = ref.watch(imageProvider);
            return ImageGrid(images: images);
          },
        ),
      ),
    );
  }

  PreferredSizeWidget buildCustomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(SizeConstants.size80),
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
            top: SizeConstants.size4, right: SizeConstants.size20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // Ensure Column takes minimal height needed
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/ic_pixabay_logo.png',
                  height: SizeConstants.size60,
                ),
                SizedBox(
                  width: SizeConstants.size8,
                ),
                const Expanded(child: SearchField()),
              ],
            ),
            const Divider(thickness: 0.5, color: ColorConstants.darkGrey),
          ],
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
