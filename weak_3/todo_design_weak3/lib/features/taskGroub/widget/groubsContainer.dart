import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_design_weak3/core/utils/TextFormFieldController.dart';
import 'package:todo_design_weak3/core/utils/app_color.dart';
import 'package:todo_design_weak3/features/taskGroub/groubOfTask.dart';

class Groubscontainer extends StatefulWidget {
  const Groubscontainer({super.key});

  @override
  State<Groubscontainer> createState() => _CategorycontainerState();
}

class _CategorycontainerState extends State<Groubscontainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
