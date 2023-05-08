import 'package:nfc_demo/common_libs.dart';

part 'loading_state.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(LoadingInitial());

  void show() {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(LoadingVisible());
  }

  void hide() => emit(LoadingInitial());

  void showUnlock() {
    FocusManager.instance.primaryFocus?.unfocus();
    emit(LoadingUnlock());
  }

  void unlockSuccessful() => emit(LoadingUnlockComplete());

  void hideWithDelay(Duration duration) {
    Future.delayed(duration, () => emit(LoadingInitial()));
  }
}
