// @dart=2.9

import 'package:flutter/material.dart';
import 'package:tolr_app/components/todlr_button.dart';
import 'package:tolr_app/utils/todlr_colors.dart';

class ErrorSwitcher extends StatelessWidget {
  final VoidCallback onRetry;
  final String message, subMessage;
  final dynamic error;

  const ErrorSwitcher(
      {this.onRetry,
      this.error,
      @required this.message,
      this.subMessage,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return _ErrorWidget(
      message: message,
      onRetry: onRetry,
      subMessage: subMessage,
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({
    Key key,
    this.onRetry,
    @required this.message,
    this.subMessage,
  }) : super(key: key);

  final VoidCallback onRetry;
  final String message, subMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Something went wrong",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: textV2Colour,
                  fontSize: 18,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Error",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyText2.copyWith(
                  color: textV2Colour,
                  fontSize: 12,
                ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TodlrButton(
                title: "Retry",
                callback: onRetry,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
