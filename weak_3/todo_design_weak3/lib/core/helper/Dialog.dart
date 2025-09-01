import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/widgets/Button.dart';
import 'package:todo_design_weak3/core/widgets/TextFormField.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_cubit.dart';
import 'package:todo_design_weak3/features/tasks/cubit/task_state.dart';

class TaskFilterDialog extends StatefulWidget {
  const TaskFilterDialog({super.key});

  @override
  State<TaskFilterDialog> createState() => _TaskFilterDialogState();
}

class _TaskFilterDialogState extends State<TaskFilterDialog> {
  String selectedCategory = 'All';
  String selectedStatus = 'All';

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 380,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColor.buttonTextColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColor.shadowFilterContainer,
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildFilterChip('All', selectedCategory == 'All', () {
                  setState(() => selectedCategory = 'All');
                }),
                _buildFilterChip('Work', selectedCategory == 'Work', () {
                  setState(() => selectedCategory = 'Work');
                }),
                _buildFilterChip('Home', selectedCategory == 'Home', () {
                  setState(() => selectedCategory = 'Home');
                }),
                _buildFilterChip(
                  'Personal',
                  selectedCategory == 'Personal',
                  () {
                    setState(() => selectedCategory = 'Personal');
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            BlocBuilder<TaskCubit, TaskState>(
              builder: (context, state) {
                return Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildFilterChip('All', selectedStatus == 'All', () {
                      setState(() => selectedStatus = 'All');
                    }),
                    _buildFilterChip(
                      'In Progress',
                      selectedStatus == 'In Progress',
                      () {
                        setState(() => selectedStatus = 'In Progress');
                      },
                    ),
                    _buildFilterChip('Missed', selectedStatus == 'Missed', () {
                      setState(() => selectedStatus = 'Missed');
                    }),
                    _buildFilterChip('Done', selectedStatus == 'Done', () {
                      setState(() => selectedStatus = 'Done');
                    }),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColor.bordersFilterContainer),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: MyTextFormField(
                controller: Textformfieldcontroller.endtimecontroller,
                readonly: true,
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    final TimeOfDay? pickedTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );

                    if (pickedTime != null) {
                      final DateTime finalDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );

                      final formatted = DateFormat(
                        "d MMMM, yyyy h:mm a",
                      ).format(finalDateTime);

                      Textformfieldcontroller.endtimecontroller.text =
                          formatted;
                    }
                  }
                },
                hintText: "End Time",
                prefixIcon: Icon(
                  Icons.calendar_month_rounded,
                  color: AppColor.baseColor,
                ),
              ),
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: MyButton(
                backgroundColor: AppColor.baseColor,
                text: "Filter",
                onPressed: () {
                  Navigator.of(context).pop({
                    'category': selectedCategory,
                    'status': selectedStatus,
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.baseColor : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? AppColor.baseColor
                : AppColor.borderFilterContainer,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
