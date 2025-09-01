class LanguageState {
  String? selectedLanguage;
  LanguageState({this.selectedLanguage});
}

class InitialState extends LanguageState {
  InitialState({String? selectedLanguage})
    : super(selectedLanguage: selectedLanguage);
}

class ArabicState extends LanguageState {
  ArabicState({String? selectedLanguage})
    : super(selectedLanguage: selectedLanguage);
}

class EnglishState extends LanguageState {
  EnglishState({String? selectedLanguage})
    : super(selectedLanguage: selectedLanguage);
}
