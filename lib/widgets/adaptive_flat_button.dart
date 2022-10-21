import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFlatButton extends StatelessWidget {
  final String text;
  final VoidCallback  handler;  //Function  handler
  //Change your code to accept a VoidCallback instead of Function for the onPressed.
  // By the way VoidCallback is just shorthand for void Function() so you could also define it as final void Function() onPressed;

  AdaptiveFlatButton(this.text, this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: handler,
    )
        : FlatButton(
      textColor: Theme.of(context).primaryColor,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: handler,
    );
  }
}
