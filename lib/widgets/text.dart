import 'package:flutter/material.dart';
import 'package:habito/models/universalValues.dart';

class CustomText extends StatelessWidget {
  final String content;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final Color color;
  final double fontSize;
  final TextDecoration textDecoration;
  final double letterSpacing;
  final bool alternateFont;
  final Function onTap;
  const CustomText(this.content,
      {this.fontWeight,
      this.textAlign,
      this.color,
      this.fontSize,
      this.textDecoration,
      this.letterSpacing,
      this.alternateFont,
      this.onTap});
  @override
  Widget build(BuildContext context) {
    final Widget text = Text(
      content,
      textAlign: textAlign == null ? TextAlign.start : TextAlign.center,
      style: TextStyle(
          fontFamily: (alternateFont != null && alternateFont)
              ? 'productsans'
              : 'roboto',
          fontWeight: fontWeight == null ? FontWeight.normal : fontWeight,
          color: color == null ? MyColors.white : color,
          letterSpacing: letterSpacing == null ? 0 : letterSpacing,
          fontSize: fontSize == null ? 20 : fontSize,
          decoration:
              textDecoration == null ? TextDecoration.none : textDecoration),
    );

    if (onTap == null) {
      return text;
    }
    return GestureDetector(
      onTap: onTap,
      child: text,
    );
  }
}
