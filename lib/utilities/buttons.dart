import 'package:flutter/material.dart';

class NamedButton extends StatelessWidget {
  final VoidCallback voidCallback;
  final String buttonName;
  final Color? color;
  const NamedButton({
    super.key,
    required this.voidCallback,
    required this.buttonName,
    this.color = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
      ),
      onPressed: voidCallback,
      child: Text(buttonName),
      color: color,
      elevation: 0,
    );
  }
}
