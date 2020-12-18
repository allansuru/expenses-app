import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final Function submit;
  final TextEditingController controller;
  final String title;
  final bool isNumeric;

  AdaptativeTextField(
      {this.submit, this.controller, this.title, this.isNumeric});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        child: Platform.isIOS
            ? CupertinoTextField(
                placeholder: title,
                onSubmitted: (_) => submit,
                controller: controller,
                keyboardType: isNumeric
                    ? TextInputType.numberWithOptions(decimal: true)
                    : TextInputType.text,
              )
            : TextField(
                onSubmitted: (_) => submit,
                controller: controller,
                decoration: InputDecoration(labelText: title),
                keyboardType: isNumeric
                    ? TextInputType.numberWithOptions(decimal: true)
                    : TextInputType.text,
              ),
      ),
    );
  }
}
