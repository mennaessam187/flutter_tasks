import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/core/widgets/TextFormField.dart';
import 'package:todo_design_weak3/features/taskGroub/groubOfTask.dart';

class Groubtextformfield extends StatefulWidget {
  const Groubtextformfield({super.key});

  @override
  State<Groubtextformfield> createState() => _GroubtextformfieldState();
}

class _GroubtextformfieldState extends State<Groubtextformfield> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyTextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "This field cannot be empty";
            }
            return null;
          },
          controller: Textformfieldcontroller.groubcontroller,

          hintText: "Group",
          prefixIcon: Textformfieldcontroller.selectedGroup != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    Textformfieldcontroller.selectedGroup!['icon']!,
                    width: 24,
                    height: 24,
                  ),
                )
              : null,
          suffixIcon: GestureDetector(
            onTap: () => setState(
              () => Textformfieldcontroller.isOpen =
                  !Textformfieldcontroller.isOpen,
            ),
            child: Icon(Icons.keyboard_arrow_down),
          ),
          readonly: true,
          onTap: () => setState(
            () => Textformfieldcontroller.isOpen =
                !Textformfieldcontroller.isOpen,
          ),
        ),
        if (Textformfieldcontroller.isOpen)
          Container(
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColor.buttonTextColor, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: groups.map((group) {
                return ListTile(
                  leading: SvgPicture.asset(group['icon']!),
                  title: Text(group['name'] as String),
                  onTap: () {
                    setState(() {
                      Textformfieldcontroller.selectedGroup = {
                        'name': group['name'] as String,
                        'icon': group['icon']!,
                      };
                      Textformfieldcontroller.groubcontroller.text =
                          Textformfieldcontroller.selectedGroup?['name'] ?? '';
                      Textformfieldcontroller.isOpen = false;
                    });
                  },
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
