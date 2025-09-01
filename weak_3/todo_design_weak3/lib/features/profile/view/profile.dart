import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_design_weak3/core/utils/appBar.dart';
import 'package:todo_design_weak3/core/utils/app_icon.dart';
import 'package:todo_design_weak3/features/auth/data/models/usermodel.dart';
import 'package:todo_design_weak3/features/profile/view/changePassword.dart';
import 'package:todo_design_weak3/features/profile/view/language.dart';
import 'package:todo_design_weak3/features/profile/view/updateProfile.dart';
import 'package:todo_design_weak3/features/profile/widget/container.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel? use;
  const ProfileScreen({super.key, this.use});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Appbarw(),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UpdateprofileScreen(user: use),
                  ),
                );
              },
              child: MyContainer(
                text: "Profile",
                icon: SvgPicture.asset(Appicons.profile),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ChangepasswordScreen(),
                  ),
                );
              },
              child: MyContainer(
                text: "Change Password",
                icon: SvgPicture.asset(Appicons.lock),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LanguageScreen()),
                );
              },
              child: MyContainer(
                text: "Settings",
                icon: SvgPicture.asset(Appicons.setting),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
