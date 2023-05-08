import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'alert_state.dart';

class AlertCubit extends Cubit<AlertState> {
  AlertCubit() : super(AlertInitial());

  void show(String msg, {String? title}) {
    emit(AlertMessage(msg, title));
    emit(AlertInitial());
  }
}
