import 'package:flutter/material.dart';

class MIconButton extends StatelessWidget {

  final double radius;
  final Color color;
  final Widget child;
  final EdgeInsets padding;
  final Function()? onTap;
  const MIconButton({Key? key, this.radius = 32,this.padding = const EdgeInsets.all(12), this.color = Colors.white, required this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: color,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: color)),

          child: child,
        ),
      ),
    );
  }
}