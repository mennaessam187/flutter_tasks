import 'package:flutter/material.dart';
import 'package:news_app_nti/core/utils/colors.dart';

class ContainerCategory extends StatelessWidget {
  final bool isSelectedf;
  final Widget children;
  const ContainerCategory({
    super.key,
    required this.children,
    required this.isSelectedf,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: isSelectedf ? AppColor.appbarbackground : Colors.white,
        borderRadius: BorderRadius.circular(56),
        border: Border.all(width: 1, color: AppColor.appbarbackground),
        boxShadow: [
          BoxShadow(color: AppColor.formfieldbackground, offset: Offset.zero),
        ],
      ),
      child: children,
    );
  }
}
