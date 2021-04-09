
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Button extends StatelessWidget {

  String label;

  Function onPressed;

  Color color;

  Color fontColor;

  Button(this.label, {@required this.onPressed, @required this.color, @required this.fontColor});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: color,
        child: Text(
          label,
          style: TextStyle(
            color: fontColor,
            fontSize: 20,
        ),
        ),
        onPressed: onPressed,
    );
  }

}