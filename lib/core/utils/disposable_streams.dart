import 'dart:async';

class DisposableStream {
  final List<StreamSubscription> _subs = [];

  void cancelSubscriptions() {
    for (var subscription in _subs) {
      subscription.cancel();
    }
  }

  void addSubscription(StreamSubscription sub) {
    _subs.add(sub);
  }
}

extension DisposableStreamSubscriton on StreamSubscription {
  void canceledBy(DisposableStream disposable) {
    disposable.addSubscription(this);
  }
}
