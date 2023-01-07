import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final double top;
  final double right;
  final Widget child;

  final Color color;

  const BadgeWidget(
      {Key? key,
      required this.child,
      this.color = Colors.red,
      required this.top,
      required this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: right,
          top: top,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color,
            ),
            constraints: const BoxConstraints(minWidth: 7, minHeight: 7),
          ),
        )
      ],
    );
  }
}
