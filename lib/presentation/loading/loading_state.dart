part of 'loading_cubit.dart';

extension LoadingStateX on LoadingState {
  bool get isInitial => this is LoadingInitial;

  bool get isVisible => this is LoadingVisible;

  bool get isUnlock => this is LoadingUnlock;

  bool get isUnlockComplete => this is LoadingUnlockComplete;
}

abstract class LoadingState {
  const LoadingState();
}

class LoadingInitial extends LoadingState {}

class LoadingVisible extends LoadingState {}

class LoadingUnlock extends LoadingState {}

class LoadingUnlockComplete extends LoadingState {}