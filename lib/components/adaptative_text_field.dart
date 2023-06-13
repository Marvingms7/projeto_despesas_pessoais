import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField({
    super.key,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onSubmitted,
    this.label,
  });

  final String? label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              controller: controller,
              keyboardType: keyboardType,
              placeholder: label,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 20),
            ),
          )
        : TextField(
            controller: controller,
            keyboardType: keyboardType,
            onSubmitted: onSubmitted,
            decoration: InputDecoration(labelText: label),
          );
  }
}
