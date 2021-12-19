// @dart=2.9

import 'package:flutter/material.dart';

class TodlrAppBar extends AppBar {
  TodlrAppBar({
    Key key,
    Widget leading,
    bool automaticallyImplyLeading = true,
    Widget title,
    List<Widget> actions,
    Widget flexibleSpace,
    PreferredSizeWidget bottom,
    double elevation = 0,
    Color backgroundColor,
    Brightness brightness,
    IconThemeData iconTheme,
    TextTheme textTheme,
    bool primary = true,
    bool centerTitle,
    double titleSpacing = NavigationToolbar.kMiddleSpacing,
    double toolbarOpacity = 1,
    double bottomOpacity = 1,
  }) : super(
          key: key,
          leading: leading,
          automaticallyImplyLeading: automaticallyImplyLeading,
          title: title,
          actions: actions,
          flexibleSpace: flexibleSpace ??
              SafeArea(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                ),
              ),
          bottom: bottom,
          elevation: elevation,
          backgroundColor: Colors.transparent,
          brightness: brightness,
          iconTheme: iconTheme ?? const IconThemeData(color: Colors.black),
          textTheme: textTheme,
          primary: primary,
          centerTitle: centerTitle,
          titleSpacing: titleSpacing,
          toolbarOpacity: toolbarOpacity,
          bottomOpacity: bottomOpacity,
        );
}
