import 'package:flutter/material.dart';

class MGradientContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const MGradientContainer({Key? key, required this.child, this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: padding,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            ),
        child: child);
  }
}
