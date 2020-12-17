import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptativeButton extends StatelessWidget {
  final String title;
  final Function onPressed;

  AdaptativeButton({this.title, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Platform.isIOS
            ? CupertinoButton(
                child: Text(title),
                onPressed: onPressed,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 20),
              )
            : RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                child: Text(title),
                onPressed: onPressed,
              ));
  }
}
