import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/utils/app_icon.dart';
import 'package:todo_design_weak3/core/widgets/loding.dart';
import 'package:todo_design_weak3/features/home/widget/smallContainer.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_cubit.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_state.dart';
import 'package:todo_design_weak3/features/tasks/data/models/task_model.dart';

class PersonalTasksScreen extends StatefulWidget {
  const PersonalTasksScreen({super.key});

  @override
  State<PersonalTasksScreen> createState() => _PersonalTasksScreenState();
}

class _PersonalTasksScreenState extends State<PersonalTasksScreen> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().startPersonalTasksStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, state) {
                    return state is Getpersonaltasks
                        ? Smallcontainer(
                            fontsize: 15,
                            width: 23.w,
                            height: 23.h,
                            color: AppColor.personalBackgroundcolor,
                            number: "${state.task.length}",
                          )
                        : SizedBox();
                  },
                ),
                Text(
                  ' Personal Tasks',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios_new),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.baseColor,
        shape: CircleBorder(),
        onPressed: () async {
          final result = await Navigator.of(context).pushNamed("addTask");
          if (result == true) {
            context.read<TaskCubit>().startPersonalTasksStream();
          }
        },
        child: Icon(Icons.note_add_outlined, color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<TaskCubit, TaskState>(
          builder: (context, state) {
            if (state is GetTaskLoding) {
              return LoddingState();
            } else if (state is Getpersonaltasks) {
              if (state.task.isEmpty) {
                return _buildEmptyState();
              }
              return _buildTasksList(state.task);
            } else if (state is GetTaskError) {
              return _buildErrorState(state.message);
            } else {
              return _buildEmptyState();
            }
          },
        ),
      ),
    );
  }

  Widget _buildTasksList(List<TaskModel> tasks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 16),
        Expanded(
          child: ListView.separated(
            itemCount: tasks.length,
            separatorBuilder: (context, index) => SizedBox(height: 12),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return _buildTaskCard(task);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTaskCard(TaskModel task) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.personalBackgroundcolor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Color.fromRGBO(206, 235, 220, 1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  task.title ?? 'No Title',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColor.baseColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Appicons.personal, width: 16, height: 16),
                    SizedBox(width: 4),
                    Text(
                      'Personal',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (task.description != null && task.description!.isNotEmpty) ...[
            SizedBox(height: 8),
            Text(
              task.description!,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
          if (task.date != null && task.date!.isNotEmpty) ...[
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  task.date!,
                  style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Appicons.personal, width: 80, height: 80),
          SizedBox(height: 24),
          Text(
            'No Personal Tasks',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Add your first personal task to get started!',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 80, color: Colors.red[300]),
          SizedBox(height: 24),
          Text(
            'Oops! Something went wrong',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<TaskCubit>().startPersonalTasksStream();
            },
            child: Text('Try Again'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.baseColor,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // @override
  // void dispose() {
  //   context.read<TaskCubit>().stopAllStreams();
  //   super.dispose();
  // }
}
