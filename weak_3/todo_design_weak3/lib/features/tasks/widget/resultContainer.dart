import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/utils/app_icon.dart';
import 'package:todo_design_weak3/core/utils/app_image.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_cubit.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_state.dart';

class Resultcontainer extends StatelessWidget {
  final Widget? child;
  final int index;
  const Resultcontainer({super.key, this.child, required this.index});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 334.w,
        height: 95.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 70.h,
                width: 100.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: AssetImage(Appimage.phalistineImage),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                    Appimage.phalistineImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15),
              BlocBuilder<TaskCubit, TaskState>(
                builder: (context, state) {
                  if (state is GetTaskSuccessextends) {
                    return Column(
                      children: state.task.map((task) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              width: 170,
                              child: Text(
                                "No Title", // عرض العنوان
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: AppColor.baseColor,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(6),
                                    child: Text(
                                      "Done",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                SvgPicture.asset(
                                  Appicons.work,
                                  width: 22.w,
                                  height: 22.h,
                                ),
                              ],
                            ),
                            SizedBox(height: 12), // مسافة بين كل عنصر والتاني
                          ],
                        );
                      }).toList(),
                    );
                  } else {
                    return Text("No Tasks Yet");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
/*
// Column(
                      //     crossAxisAlignment: CrossAxisAlignment.end,
                      //     children: [
                      //       Container(width: 170, child: Text(state.task)),
                      //       Row(
                      //         children: [
                      //           Container(
                      //             decoration: BoxDecoration(
                      //               color: AppColor.baseColor,
                      //               borderRadius: BorderRadius.circular(15),
                      //             ),
                      //             child: Padding(
                      //               padding: const EdgeInsets.all(6),
                      //               child: Text(
                      //                 "Done",
                      //                 style: TextStyle(color: Colors.white),
                      //               ),
                      //             ),
                      //           ),
                      //           SizedBox(width: 10),
                      //           SvgPicture.asset(
                      //             Appicons.work,
                      //             width: 22.w,
                      //             height: 22.h,
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   )
*/