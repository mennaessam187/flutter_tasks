import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/utils/app_image.dart';
import 'package:todo_design_weak3/core/widgets/Button.dart';
import 'package:todo_design_weak3/features/home/view/homeScreen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(45),
                child: SvgPicture.asset(Appimage.startImage),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Text(
                    "Welcome To",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
                  ),
                  Text(
                    "Do It!",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 22),
              Text(
                "Ready to conquer your tasks? Let's Do\nIt together",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.greyTextColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 40),
              MyButton(
                text: "Let's Start",
                backgroundColor: Color.fromRGBO(20, 153, 84, 1),
                onPressed: () {
                  (FirebaseAuth.instance.currentUser != null &&
                          FirebaseAuth.instance.currentUser!.emailVerified)
                      ? Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Homescreen()),
                        )
                      : Navigator.of(context).pushReplacementNamed("login");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
