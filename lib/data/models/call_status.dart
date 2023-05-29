enum CallStatus { initial, loading, success, failure }

extension CallStatusX on CallStatus {
  bool get isInitial => this == CallStatus.initial;

  bool get isLoading => this == CallStatus.loading;

  bool get isSuccess => this == CallStatus.success;

  bool get isFailure => this == CallStatus.failure;
}
