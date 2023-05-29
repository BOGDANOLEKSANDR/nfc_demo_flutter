import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.navigate_before_rounded),
      onPressed: () => Navigator.maybePop(context),
    );
  }
}
