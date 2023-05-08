import 'package:nfc_demo/common_libs.dart';

import 'alert_cubit.dart';

class AlertScreen extends StatelessWidget {
  final Widget child;

  const AlertScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AlertCubit, AlertState>(
      listener: (context, state) {
        if (state is AlertMessage) {
          showAlert(context, title: state.title, message: state.msg);
        }
      },
      builder: (context, state) => child,
    );
  }

  showAlert(BuildContext context, {String? title, required String message}) {
    showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title != null ? Text(title.tt(context)) : null,
            content: SingleChildScrollView(child: Text(message.tt(context))),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: Text('Ok'.tt(context))),
            ],
          );
        });
  }
}
