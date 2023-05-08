import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';
import 'package:nfc_demo/common_libs.dart';
import 'package:nfc_demo/data/http/http_client.dart';
import 'package:nfc_demo/logic/language/language_cubit.dart';
import 'package:nfc_demo/logic/translation_cubit.dart';
import 'package:nfc_demo/presentation/alert/alert_cubit.dart';

final getIt = GetIt.I;

void init() {
  getIt.registerLazySingleton<Client>(() => InterceptedClient.build(interceptors: [
        LoggingInterceptor(),
      ]));

  getIt.registerLazySingleton<HttpClient>(() => HttpClient(getIt<Client>()));
  getIt.registerLazySingleton<ConfigService>(() => ConfigService());

  getIt.registerLazySingleton<CallService>(() => CallService(getIt<HttpClient>(), getIt<ConfigService>()));

  getIt.registerLazySingleton<LanguageRepository>(
    () => LanguageRepository(getIt<CallService>()),
  );

  getIt.registerLazySingleton<TranslationRepository>(() => TranslationRepository(getIt<CallService>()));

  getIt.registerSingleton<AlertCubit>(AlertCubit());

  getIt.registerSingleton<LanguageCubit>(LanguageCubit(
    languageRepository: getIt(),
  ));

  getIt.registerSingleton<TranslationCubit>(TranslationCubit(
    languageCubit: getIt(),
    translationService: getIt(),
  ));
}
