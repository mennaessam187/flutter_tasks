import 'package:flutter/material.dart';

class Smallcontainer extends StatelessWidget {
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final String? number;
  final double? fontsize;
  const Smallcontainer({
    super.key,
    this.color,
    this.number,
    this.textColor,
    this.height,
    this.width,
    this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          number!,
          style: TextStyle(color: textColor, fontSize: fontsize),
        ),
      ),
    );
  }
}
