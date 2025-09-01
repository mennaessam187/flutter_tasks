import 'package:flutter/material.dart';

import 'package:todo_design_weak3/core/utils/app_color.dart';

class Homecontainer extends StatelessWidget {
  final Function()? onTap;
  const Homecontainer({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 335,
      decoration: BoxDecoration(
        color: AppColor.baseColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(),
              child: Text(
                "Your today’s tasks almost done!",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "80%",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 36,
                    width: 121,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: Text(
                        "View Tasks",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppColor.baseColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
