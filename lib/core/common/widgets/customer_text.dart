import 'package:gainz_ai_app/core/res/colours.dart';
import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  CustomText(
     {
    super.key,
    this.maxLines,
    this.overflow, this.fontSize, this.color, this.fontWeight, 
    this.text,
  });

  final String? text;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text!,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
      style: 
          TextStyle(
            fontSize: widget.fontSize ?? 12,
            color: widget.color ?? Colors.black,
            fontWeight: widget.fontWeight ?? FontWeight.normal,
          ),
    );
  }
}
