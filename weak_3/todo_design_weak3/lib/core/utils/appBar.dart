import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/utils/app_image.dart';
import 'package:todo_design_weak3/core/widgets/loding.dart';
import 'package:todo_design_weak3/features/home/user_cubit/user_cubit.dart';
import 'package:todo_design_weak3/features/home/user_cubit/user_state.dart';
import 'package:todo_design_weak3/features/profile/view/profile.dart';

class Appbarw extends StatelessWidget {
  const Appbarw({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(Appimage.phalistineImage),
          ),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello!",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  color: AppColor.blackTextColor,
                ),
              ),

              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UserLodding) {
                    LoddingState();
                  } else if (state is UserSuccess) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(use: state.usermodel),
                          ),
                        );
                      },
                      child: Text(
                        state.usermodel.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w300,
                          color: AppColor.blackTextColor,
                        ),
                      ),
                    );
                  } else if (state is UserError) {
                    return Text(
                      state.message,
                      style: TextStyle(color: Colors.red),
                    );
                  }
                  return SizedBox();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
