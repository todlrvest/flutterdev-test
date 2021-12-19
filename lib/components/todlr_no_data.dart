// @dart=2.9

import 'package:flutter/material.dart';

class TodlrNoData extends StatelessWidget {
  const TodlrNoData(
    this.message, {
    this.child,
    Key key,
    this.size = 18,
  }) : super(key: key);

  final Widget child;
  final String message;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: child ??
          Text(
            message,
            style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
    );
  }
}
