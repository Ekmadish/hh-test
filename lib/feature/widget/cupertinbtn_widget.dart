import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BtnWidget extends StatelessWidget {
  final Widget child;
  final String? text;
  final VoidCallback onTap;

  const BtnWidget(
      {Key? key, required this.onTap, required this.child, this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
        pressedOpacity: .2,
        color: Colors.transparent,
        padding: EdgeInsets.zero,
        onPressed: onTap,
        child: child);
  }
}
