import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_design_weak3/core/utils/app_icon.dart';

// class Searchtextformfield extends StatelessWidget {
//   const Searchtextformfield({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.white,
//         hintText: "Search...",
//         suffixIcon: IconButton(
//           onPressed: () {},
//           icon: SvgPicture.asset(Appicons.search),
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(7),
//           borderSide: BorderSide(color: Colors.white, style: BorderStyle.none),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.white, style: BorderStyle.none),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.white, style: BorderStyle.none),
//         ),
//       ),
//     );
//   }
// }
class Searchtextformfield extends StatelessWidget {
  final ValueChanged<String>? onChanged;

  const Searchtextformfield({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged, // << مهم
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: "Search...",
        suffixIcon: IconButton(
          onPressed: () {},
          icon: SvgPicture.asset(Appicons.search),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: Colors.white, style: BorderStyle.none),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, style: BorderStyle.none),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, style: BorderStyle.none),
        ),
      ),
    );
  }
}
