import 'package:flutter/material.dart';



class MyContainer extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  const MyContainer({super.key, this.padding, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: padding,
      child: child
    );
  }
}
