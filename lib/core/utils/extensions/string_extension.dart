import 'package:nfc_demo/common_libs.dart';
import 'package:nfc_demo/logic/translation_cubit.dart';

extension StringX on String {
  String tt(BuildContext context) {
    return context.watch<TranslationCubit>().translate(this);
  }
}
