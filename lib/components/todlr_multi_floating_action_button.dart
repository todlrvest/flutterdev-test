// @dart=2.9

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:tolr_app/components/todlr_scaffold.dart';

class TodlrMultiFloatingActionButton extends StatefulWidget {
  const TodlrMultiFloatingActionButton({
    Key key,
    this.buttons,
  }) : super(key: key);

  final List<FloatingAction> buttons;

  @override
  _TodlrMultiFloatingActionButtonState createState() =>
      _TodlrMultiFloatingActionButtonState();
}

class _TodlrMultiFloatingActionButtonState
    extends State<TodlrMultiFloatingActionButton>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;

  final Curve _curve = Curves.easeOut;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(
        () {
          setState(() {});
        },
      );

    _animateIcon = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _animateColor = ColorTween(
      begin: Colors.black,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  void toggle() {
    if (!_isOpen) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    TodlrNPScaffold.of(context).toggleBlur();
    _isOpen = !_isOpen;
  }

  Widget _closeButton() {
    return Container(
      alignment: AlignmentDirectional.bottomEnd,
      child: FloatingActionButton(
        backgroundColor: _animateColor.value,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, Widget child) {
            return Transform(
              transform: Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
              alignment: FractionalOffset.center,
              child: AnimatedIcon(
                icon: AnimatedIcons.menu_close,
                color: Colors.red,
                progress: _animateIcon,
              ),
            );
          },
        ),
        onPressed: toggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final buttons = widget.buttons.map((b) {
      final index = widget.buttons.indexOf(b);
      return Container(
        child: ScaleTransition(
          alignment: FractionalOffset.centerRight,
          scale: CurvedAnimation(
            parent: _controller,
            curve: Interval(0.4, 1.0 - index / widget.buttons.length / 2.0,
                curve: Curves.easeOut),
          ),
          child: FloatingAction(
            label: b.label,
            mini: b.mini,
            image: b.image,
            icon: b.icon,
            lableColor: b.lableColor,
            lableBackground: b.lableBackground,
            onPressed: () {
              b.onPressed();
              toggle();
            },
          ),
        ),
      );
    }).toList();
    buttons.add(_closeButton());
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: buttons,
    );
  }
}

class FloatingAction extends StatelessWidget {
  const FloatingAction({
    Key key,
    this.label,
    this.image,
    this.icon,
    this.onPressed,
    this.lableColor,
    this.lableBackground,
    this.mini = true,
  }) : super(key: key);

  final String label;
  final String image;
  final IconData icon;
  final VoidCallback onPressed;
  final Color lableColor;
  final Color lableBackground;
  final bool mini;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mini ? EdgeInsets.zero : const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            color: lableBackground ?? Colors.transparent,
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FloatingActionButton(
            mini: mini,
            heroTag: null,
            child: image != null
                ? Image.asset(
                    image,
                    color: Colors.black,
                    scale: 2.5,
                  )
                : Icon(
                    icon,
                    color: Colors.black,
                    size: 18,
                  ),
            onPressed: onPressed,
          ),
        ],
      ),
    );
  }
}
