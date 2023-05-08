import 'package:nfc_demo/data/service/call_service.dart';
import 'package:rxdart/rxdart.dart';

class TranslationRepository {
  final CallService _call;

  TranslationRepository(
    CallService callService,
  ) : _call = callService;

  Stream<dynamic> getTranslations(int languageId) {
    return _call
        .make<Map<String, dynamic>>('common/getTranslations',
            payload: {'override_language_id': languageId}, onthemove: true)
        .doOnData((event) {})
        .map((data) => data.map((key, value) => MapEntry(key, value.toString())));
  }
}
