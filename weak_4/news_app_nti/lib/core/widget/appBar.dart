import 'package:flutter/material.dart';
import 'package:news_app_nti/core/utils/colors.dart';

class AppBarr extends StatelessWidget {
  final Widget? children;
  const AppBarr({super.key,required this.children});

  @override
  Widget build(BuildContext context) {
    return Container( 
      decoration: BoxDecoration( 
        color: AppColor.appbarbackground
      ),
      child: children,
    );
  }
}