import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField(
      this.controller, this.keyboardType, this.onSubmitted,
      {super.key});

  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoTextField()
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            decoration: const InputDecoration(labelText: 'Valor R\$'),
            onSubmitted: onSubmitted,
          );
  }
}
