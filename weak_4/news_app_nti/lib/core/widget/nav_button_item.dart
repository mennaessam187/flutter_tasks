// import 'package:flutter/material.dart';

// class NavButtonItem extends StatelessWidget {
//   final int currentIndex; // index اللي واقف عليه
//   final int itemIndex;    // index بتاع الزر نفسه
//   final String text;
//   final Widget icon;

//   const NavButtonItem({
//     super.key,
//     required this.currentIndex,
//     required this.itemIndex,
//     required this.text,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final bool isSelected = currentIndex == itemIndex;

//     if (isSelected) {
//       // ✅ الشكل لما يكون مختار
//       return Container(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//         decoration: BoxDecoration(
//           color: Colors.black,
//           borderRadius: BorderRadius.circular(24),
//         ),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             icon,
//             const SizedBox(width: 6),
//             Text(
//               text,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ],
//         ),
//       );
//     } else {
//       return Icon(
//       icon,
//         color: Colors.grey,
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';

class NavButtonItem extends StatelessWidget {
  final int currentIndex;   // الإندكس الحالي المختار
  final int itemIndex;      // إندكس الزر نفسه
  final String text;
  // دالة ترجع الويجت (Icon/SVG) حسب اللون المطلوب
  final Widget Function(Color color) iconBuilder;

  // ألوان قابلة للتخصيص
  final Color selectedBgColor;
  final Color selectedFgColor;
  final Color unselectedIconColor;

  const NavButtonItem({
    super.key,
    required this.currentIndex,
    required this.itemIndex,
    required this.text,
    required this.iconBuilder,
    this.selectedBgColor = Colors.black,
    this.selectedFgColor = Colors.white,
    this.unselectedIconColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSelected = currentIndex == itemIndex;

    if (isSelected) {
      // الشكل المختار: خلفية + أيقونة + نص
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selectedBgColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconBuilder(selectedFgColor),
            const SizedBox(width: 6),
            Text(
              text,
              style: TextStyle(color: selectedFgColor),
            ),
          ],
        ),
      );
    } else {
      // الشكل العادي: أيقونة بس بالرمادي
      return iconBuilder(unselectedIconColor);
    }
  }
}
