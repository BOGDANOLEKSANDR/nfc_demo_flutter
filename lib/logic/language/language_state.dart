part of 'language_cubit.dart';

class LanguageState extends Equatable {
  final Map<int, Language> languages;
  final Language selectedLanguage;

  const LanguageState({
    this.languages = const {},
    required this.selectedLanguage,
  });

  LanguageState copyWith({
    Map<int, Language>? languages,
    Language? selectedLanguage,
  }) {
    return LanguageState(
      languages: languages ?? this.languages,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  @override
  List<Object?> get props => [languages, selectedLanguage];
}