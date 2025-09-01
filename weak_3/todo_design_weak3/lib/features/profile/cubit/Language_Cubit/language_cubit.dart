import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_design_weak3/features/profile/cubit/Language_Cubit/language_state.dart';

List languageList = ['AR', 'EN'];

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(InitialState(selectedLanguage: languageList[1]));

  static LanguageCubit get(context) => BlocProvider.of(context);
  changeLanguage(String Language) {
    if (Language == "AR") {
      emit(ArabicState(selectedLanguage: "AR"));
    } else if (Language == "EN") {
      emit(EnglishState(selectedLanguage: "EN"));
    }
  }
}
