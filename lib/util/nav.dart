import 'package:flutter/material.dart';

Future navigate(BuildContext context, Widget page, {bool replace = false}) {
  Future navigator;

  if (replace) {
    navigator =  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  } else {
    navigator =  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  return navigator;
}