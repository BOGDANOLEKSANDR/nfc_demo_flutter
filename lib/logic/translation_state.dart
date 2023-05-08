part of 'translation_cubit.dart';

class TranslationState extends Equatable {
  final Map<String, String> translations;

  const TranslationState({
    this.translations = const {},
  });

  TranslationState copyWith({
    Map<String, String>? translations,
  }) {
    return TranslationState(
      translations: translations ?? this.translations,
    );
  }

  @override
  List<Object?> get props => [translations];
}
