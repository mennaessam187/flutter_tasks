import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/core/utils/icons.dart';
import 'package:news_app_nti/feature/welcome/view/welcome_screen.dart';

class SplacheScreen extends StatefulWidget {
  const SplacheScreen({super.key});

  @override
  State<SplacheScreen> createState() => _SplacheScreenState();
}

class _SplacheScreenState extends State<SplacheScreen> {
   @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Khab",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: AppColor.baseFontColor,
              ),
            ),
            SvgPicture.asset(Appicons.paper, width: 40, height: 40),
            Text(
              "r",
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.w700,
                color: AppColor.baseFontColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
