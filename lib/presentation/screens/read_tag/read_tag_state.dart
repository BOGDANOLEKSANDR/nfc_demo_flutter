import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nfc_demo/common_libs.dart';

part 'read_tag_state.freezed.dart';

@freezed
class ReadTagState with _$ReadTagState {
  const factory ReadTagState({
    required String? details,
    required CallStatus status,
  }) = _ReadTagState;

  factory ReadTagState.initial() {
    return const ReadTagState(
      details: null,
      status: CallStatus.initial,
    );
  }
}
