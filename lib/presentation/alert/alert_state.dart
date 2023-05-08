part of 'alert_cubit.dart';

abstract class AlertState extends Equatable {
  const AlertState();
}

class AlertInitial extends AlertState {
  @override
  List<Object> get props => [];
}

class AlertMessage extends AlertState {
  final String msg;
  final String? title;

  const AlertMessage(this.msg, this.title);

  @override
  List<Object> get props => [msg];
}
