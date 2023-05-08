import 'dart:io';

import 'package:rxdart/rxdart.dart';
import 'package:nfc_demo/common_libs.dart';

class LanguageRepository {
  final CallService _call;

  LanguageRepository(
    CallService callService,
  ) : _call = callService;

  Stream<Map<int, Language>> getLanguages() {
    // Map<int, Language> setSelectedLanguage(Map<int, Language> languages, String selectedLanguage) {
    //   for (final language in languages.entries) {
    //     language.value.isSelected = language.value.shortName?.toLowerCase() == selectedLanguage.toLowerCase();
    //   }
    //   return languages;
    // }

    return _call
        .make<Map<String, dynamic>>('common/getLanguages', onthemove: true)
        .map((data) => data.map((key, value) => MapEntry(int.parse(key), Language.fromJson(value))))
        .switchMap((Map<int, Language> languages) {
      String defaultLocale = 'fi';

      if (defaultLocale.toLowerCase() != 'fi' || defaultLocale.toLowerCase() != 'en') defaultLocale = 'fi';
      for (final language in languages.entries) {
        language.value.isSelected = language.value.shortName?.toLowerCase() == defaultLocale.toLowerCase();
      }
      return Stream.value(languages);
    });
  }

  Stream<int?> changeLanguage(Language? language) {
    return Stream.value(language?.languageId);
    // return _settingsDataSource //
    //     .setLanguage(language?.shortName)
    //     .zipWith(
    //       _call.make<bool>('common/changeLanguage', payload: [language?.languageId]),
    //       (_, result) => _log.v('setLanguage: $result'),
    //     );
  }
}
