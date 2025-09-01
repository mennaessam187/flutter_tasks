import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

goToNamed(context, String screen) {
  Navigator.of(context).pushNamed(screen);
}

goToPush(context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}

goToNamedReplacement(context, String screen) {
  Navigator.of(context).pushReplacementNamed(screen);
}
