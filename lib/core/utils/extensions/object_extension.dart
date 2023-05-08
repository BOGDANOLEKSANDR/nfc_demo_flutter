extension ObjectX on Object? {
  bool get isNull => this == null;

  bool get isNotNull => isNull;

  bool get isNullOrEmpty => isNull || false == this || 0 == this || "" == this;

  bool get isNotNullOrEmpty => !isNullOrEmpty;
}
