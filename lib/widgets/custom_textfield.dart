import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tech_test/base/size_constants.dart';

import '../base/color_constants.dart';
import '../base/font_style.dart';

/// A customizable text field widget that can be used across the app for various input requirements.
class CustomTextField extends StatelessWidget {
  /// The hint text to be displayed when the input field is empty.
  final String hint;

  /// Whether the text field is enabled.
  final bool enabled;

  /// Whether the text in the field should be obscured (for passwords, etc.).
  final bool isObscureText;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether to allow text selection and clipboard actions (copy, paste).
  final bool enableInteractiveSelection;

  /// The [FocusNode] for managing focus.
  final FocusNode focusNode;

  /// The keyboard input type for the text field.
  final TextInputType? textInputType;

  /// The fit of the prefix icon, if any.
  final BoxFit? prefixFit;

  /// The prefix icon to be displayed at the start of the input field.
  final Icon? prefixIcon;

  /// The color of the prefix icon.
  final Color? prefixIconColor;

  /// The suffix icon to be displayed at the end of the input field.
  final String? suffixIcon;

  /// The maximum length of input allowed.
  final int? maxLength;

  /// The maximum number of lines allowed.
  final int maxLines;

  /// The action button to be displayed on the keyboard.
  final TextInputAction? textInputAction;

  /// A list of [TextInputFormatter] to control user input.
  final List<TextInputFormatter>? textInputFormatter;

  /// The [TextEditingController] for managing input text.
  final TextEditingController? controller;

  /// Callback for when the prefix icon is clicked.
  final Function? onPrefixIconClick;

  /// Callback for when the suffix icon is clicked.
  final Function? onSuffixIconClick;

  /// Callback for when the field is submitted.
  final Function? onFieldSubmitted;

  /// Callback for when the field value changes.
  final Function(String)? onChanged;

  /// Callback for when the field is tapped.
  final Function()? onTap;

  /// Controls how text is capitalized.
  final TextCapitalization capitalization;

  /// Controls the direction in which text is written.
  final TextDirection textDirection;

  /// Controls the alignment of the text.
  final TextAlign textAlign;

  /// The style to be applied to the input text.
  final TextStyle? valueTextStyle;

  /// The style to be applied to the hint text.
  final TextStyle? valueHintTextStyle;

  /// Callback to handle toggling of obscure text.
  final Function(bool)? onTapObscure;

  /// Whether to show the text or not (used for password fields).
  final bool? isShowText;

  /// The background color of the text field.
  final Color? backgroundColor;

  /// The color of the cursor.
  final Color? cursorColor;

  /// The autofill hints for the text field.
  final Iterable<String>? autofillHint;

  /// The border of the container wrapping the text field.
  final BoxBorder? boxBorder;

  /// The color of the container wrapping the text field.
  final Color? boxColor;

  /// Creates a [CustomTextField] with various customization options.
  const CustomTextField({
    super.key,
    required this.hint,
    required this.focusNode,
    required this.controller,
    this.enabled = true,
    this.isObscureText = false,
    this.readOnly = false,
    this.enableInteractiveSelection = true,
    this.textInputType,
    this.prefixFit,
    this.prefixIcon,
    this.prefixIconColor,
    this.suffixIcon,
    this.maxLength,
    this.maxLines = 1,
    this.textInputAction,
    this.textInputFormatter,
    this.onPrefixIconClick,
    this.onSuffixIconClick,
    this.onFieldSubmitted,
    this.onChanged,
    this.onTap,
    this.isShowText,
    this.capitalization = TextCapitalization.none,
    this.textDirection = TextDirection.ltr,
    this.textAlign = TextAlign.start,
    this.backgroundColor = ColorConstants.white,
    this.cursorColor = ColorConstants.black,
    this.onTapObscure,
    this.valueTextStyle,
    this.valueHintTextStyle,
    this.autofillHint,
    this.boxBorder,
    this.boxColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstants.size30),
        color: boxColor,
        border: boxBorder,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: SizeConstants.size8),
        child: TextFormField(
          autofillHints: autofillHint,
          obscureText: isObscureText ? isShowText ?? false : false,
          cursorColor: cursorColor ?? ColorConstants.grey,
          textInputAction: textInputAction,
          maxLength: maxLength,
          maxLines: maxLines,
          focusNode: focusNode,
          enabled: enabled,
          textCapitalization: capitalization,
          style: valueTextStyle ?? FontStyle.openSansSemiBoldTextColor_16,
          textAlign: textAlign,
          textDirection: textDirection,
          readOnly: readOnly,
          keyboardType: textInputType,
          obscuringCharacter: '*',
          controller: controller,
          inputFormatters: textInputFormatter,
          decoration: _textInputDecoration(),
          onChanged: (value) {
            onChanged?.call(value);
          },
          onTap: _onFieldTap,
          onFieldSubmitted: (value) => _onValueSubmitted(value),
        ),
      ),
    );
  }

  /// Returns the input decoration for the text field.
  InputDecoration _textInputDecoration() => InputDecoration(
    hintStyle: valueHintTextStyle ?? FontStyle.openSansSemiBoldTextColor_16,
    hintText: hint,
    border: InputBorder.none,
    prefixIcon: prefixIcon,
    prefixIconColor: prefixIconColor,
  );

  /// Handles the submission of the text field value.
  void _onValueSubmitted(String value) {
    if (onFieldSubmitted != null) {
      onFieldSubmitted!(value);
    }
  }

  /// Handles the tap event on the text field.
  void _onFieldTap() {
    onTap?.call();
  }
}
