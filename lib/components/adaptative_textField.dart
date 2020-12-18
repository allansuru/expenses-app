import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeTextField extends StatelessWidget {
  final Function submit;
  final TextEditingController controller;
  final String title;

  AdaptativeTextField({this.submit, this.controller, this.title});

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
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              )
            : TextField(
                onSubmitted: (_) => submit,
                controller: controller,
                decoration: InputDecoration(labelText: title),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
      ),
    );
  }
}
