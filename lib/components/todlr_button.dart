import 'package:flutter/material.dart';
import 'package:tolr_app/utils/todlr_colors.dart';

class TodlrButton extends StatelessWidget {
  final String title;
  final VoidCallback callback;
  final Color textColor, backgroundColor;

  const TodlrButton({
    Key? key,
    required this.title,
    required this.callback,
    this.textColor = Colors.white,
    this.backgroundColor = primaryColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: subTitleColor,
      onTap: callback,
      child: Container(
        height: 49,
        decoration: BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: Colors.transparent, width: 0.9),
            borderRadius: BorderRadius.circular(25)),
        child: Center(
            child: Text(title,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.w700,
                    height: 2.0))),
      ),
    );
  }
}
