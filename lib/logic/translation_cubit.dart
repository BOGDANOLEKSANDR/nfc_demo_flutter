import 'package:nfc_demo/common_libs.dart';

import 'language/language_cubit.dart';

part 'translation_state.dart';

class TranslationCubit extends Cubit<TranslationState> {
  final LanguageCubit _languageCubit;
  final TranslationRepository _translationService;

  late StreamSubscription _languageChangeSubs;

  TranslationCubit({
    required LanguageCubit languageCubit,
    required TranslationRepository translationService,
  })  : _languageCubit = languageCubit,
        _translationService = translationService,
        super(const TranslationState()) {
    _languageChangeSubs = _languageCubit.stream.listen((state) {
      loadTranslations(state.selectedLanguage.languageId);
    });
  }

  void loadTranslations(int languageId) {
    _translationService.getTranslations(languageId).listen((response) {
      Map<String, String> translations = response;
      emit(state.copyWith(translations: translations));
    });
  }

  String translate(String key) {
    return state.translations[key] ?? key;
  }

  @override
  Future<void> close() {
    _languageChangeSubs.cancel();
    return super.close();
  }
}
