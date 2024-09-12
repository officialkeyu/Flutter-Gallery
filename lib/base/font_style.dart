import 'package:flutter/material.dart';

import 'color_constants.dart';
import 'size_constants.dart';

/// A utility class that defines text styles used throughout the app.
class FontStyle {
  static const TextStyle openSansSemiBold = TextStyle(
      fontFamily: "OpenSans",
      fontWeight: SizeConstants.fontWeightSemiBold,
      color: ColorConstants.black);

  static final openSansSemiBoldTextColor_16 = openSansSemiBold.copyWith(
      fontSize: SizeConstants.size16, color: ColorConstants.black);

  static const TextStyle absurdWord = TextStyle(
      fontFamily: "AbsurdWord",
      fontWeight: SizeConstants.fontWeightSemiBold,
      color: ColorConstants.black);

  static final absurdWordSemiBoldTextColor_16 = absurdWord.copyWith(
      fontSize: SizeConstants.size50, color: ColorConstants.black);
}
