// @dart=2.9

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:tolr_app/components/todlr_error_switcher.dart';
import 'package:tolr_app/components/todlr_no_data.dart';
import 'package:tolr_app/utils/todlr_images.dart';

enum PageState { loading, loaded, noData, error }

class TodlrPageStateWidget extends StatelessWidget {
  final PageState pageState;
  final Widget loadingWidget;
  final WidgetBuilder builder;
  final WidgetBuilder noDataBuilder;
  final String textUnderLoader;
  final Function onRetry;
  final dynamic error;
  final String noDataMessage;

  const TodlrPageStateWidget(
      {this.pageState,
      this.loadingWidget,
      this.builder,
      this.noDataBuilder,
      this.textUnderLoader,
      this.onRetry,
      this.error,
      this.noDataMessage,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget pageBody = const SizedBox.shrink();
    switch (pageState) {
      case PageState.loading:
        pageBody = loadingWidget ?? Lottie.asset(TodlrImages.loadingLottie);
        break;
      case PageState.loaded:
        if (builder != null) pageBody = Builder(builder: builder);
        break;
      case PageState.error:
        pageBody = ErrorSwitcher(
          message: 'An error has occurred',
          onRetry: onRetry,
          error: error,
        );
        break;
      case PageState.noData:
        if (noDataBuilder != null) {
          pageBody = Builder(builder: noDataBuilder);
        } else if (noDataMessage != null) {
          pageBody = TodlrNoData(noDataMessage);
        }
        break;
    }

    return pageBody;
  }
}
