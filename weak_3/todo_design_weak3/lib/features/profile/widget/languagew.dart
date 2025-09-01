import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/features/profile/cubit/Language_Cubit/language_cubit.dart';
import 'package:todo_design_weak3/features/profile/cubit/Language_Cubit/language_state.dart';

class LanguageSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguageCubit, LanguageState>(
      builder: (context, state) {
        return Row(
          children: languageList.map((lang) {
            final isSelected = state.selectedLanguage == lang;
            return GestureDetector(
              onTap: () {
                context.read<LanguageCubit>().changeLanguage(lang);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.green : Colors.grey.shade300,
                  borderRadius: lang == 'EN'
                      ? BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                ),
                child: Text(
                  lang,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
