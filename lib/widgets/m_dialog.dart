import 'package:flutter/material.dart';

class MDialog extends StatelessWidget {
  final Widget? title;
  final Widget child;
  final double radius;
  const MDialog({Key? key, this.title, required this.child, this.radius = 8}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius * 1.25)
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              //gradient: MTheme.GRADIENT,
              borderRadius: BorderRadius.circular(radius)
            ),

            child: Material(
              color: Colors.transparent,
                borderRadius: BorderRadius.circular(radius),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: DefaultTextStyle(
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                  child: Row(
                    children: [
                      if(title != null) Expanded(child: title!),
                      //const Spacer()
                    ],
                  ),
                ),
              ),
            ),
          ),
          child
        ],
      ),
    );
  }
}
