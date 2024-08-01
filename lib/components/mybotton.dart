import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final EdgeInsetsGeometry? padding;
  const MyButton({super.key, required this.text, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: padding,
      child: Center(
        child: Text(text,style: TextStyle(color:Theme.of(context).colorScheme.surface,
            fontWeight: FontWeight.bold,fontSize: 16),),
      ),
    );
  }
}
