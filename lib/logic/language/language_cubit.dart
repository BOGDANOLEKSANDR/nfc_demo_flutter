import 'package:nfc_demo/common_libs.dart';
import 'package:rxdart/rxdart.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  static LanguageCubit get(BuildContext context) => context.read<LanguageCubit>();
  static final _log = getLogger();
  final LanguageRepository _languageRepository;

  LanguageCubit({required LanguageRepository languageRepository})
      : _languageRepository = languageRepository,
        super(LanguageState(selectedLanguage: Language.empty));

  Stream<Map<int, Language>> getLanguages() {
    return _languageRepository.getLanguages().doOnData((languages) {
      _log.w('.getLanguages().doOnData');
      final selectedLanguage = findSelectedLanguage(languages);
      _log.w('selectedLanguage = $selectedLanguage');
      emit(state.copyWith(languages: languages, selectedLanguage: selectedLanguage));
    });
  }

  static Language findSelectedLanguage(Map<int, Language> languages) {
    return languages.values.firstWhere((language) => language.isSelected);
  }

  void changeLanguage(int id) {
    for (var language in state.languages.values) {
      language.isSelected = false;
    }

    state.languages[id]?.isSelected = true;

    _languageRepository //
        .changeLanguage(state.languages[id])
        .listen(
          (_) => emit(state.copyWith(languages: state.languages, selectedLanguage: state.languages[id])),
        );
  }
}
