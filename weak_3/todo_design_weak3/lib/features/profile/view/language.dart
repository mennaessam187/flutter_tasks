import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/core/helper/pupUp.dart';
import 'package:todo_design_weak3/features/profile/cubit/Language_Cubit/language_cubit.dart';
import 'package:todo_design_weak3/features/profile/widget/languagew.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Settings",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          ),
          leading: IconButton(
            onPressed: () {
              backup(context);
            },
            icon: Icon(Icons.arrow_back_ios, size: 21),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Language",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
              ),
              BlocProvider(
                create: (context) => LanguageCubit(),
                child: LanguageSelector(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
