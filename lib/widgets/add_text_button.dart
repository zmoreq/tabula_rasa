import 'package:flutter/material.dart';

class TextAddButon extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  TextAddButon({
    required this.onPressed,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    //final theme = Theme.of(context);
    
    return FilledButton(
      onPressed: onPressed,
      style: FilledButton.styleFrom(
        fixedSize: const Size(345, 65),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 20),
          const Icon(Icons.add),
          const SizedBox(width: 50),
          Text(label),
        ],
      )
    );
  }
}