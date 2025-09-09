import 'package:flutter/material.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/core/utils/image.dart';
import 'package:news_app_nti/core/widget/elevation_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF2E5BBA).withValues(alpha: 0.9),
                    AppColor.backgroundColor,
                  ],
                ),
              ),
            ),
            Image.asset(Appimage.welcomeImage),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColor.backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32),
                    topRight: Radius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 52, right: 32, left: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Get The Latest News",
                            style: TextStyle(
                              color: AppColor.blackFontColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            " And Updates",
                            style: TextStyle(
                              color: AppColor.blackFontColor,
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        "From Politics to Entertainment: Your One-Stop Source for Comprehensive Coverage of the Latest News and Developments Across the Glob will be right on your hand.",
                        style: TextStyle(
                          fontSize: 15,
                          color: AppColor.blacklightFontColor,
                        ),
                      ),
                      SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MyElevatedButton(
                          onPressed: () {
                            Navigator.of(
                              context,
                            ).pushReplacementNamed("search");
                          },
                          children: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Explore",
                                style: TextStyle(
                                  color: AppColor.backgroundColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 3),
                              Icon(
                                Icons.arrow_right_alt_outlined,
                                color: AppColor.backgroundColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
