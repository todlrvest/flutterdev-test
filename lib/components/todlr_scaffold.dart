// @dart=2.9

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tolr_app/components/todlr_app_bar.dart';
import 'package:tolr_app/components/todlr_multi_floating_action_button.dart';
import 'package:tolr_app/components/todlr_page_state_widget.dart';

class TodlrNPScaffold extends StatefulWidget {
  /// Extras:
  ///  - Handles different [PageState] widgets using `state`
  ///  - Handles search bar
  const TodlrNPScaffold(
      {Key key,
      this.scaffoldKey,
      this.appBar,
      this.builder,
      this.noDataBuilder,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.floatingActionButtonAnimator,
      this.persistentFooterButtons,
      this.drawer,
      this.endDrawer,
      this.bottomNavigationBar,
      this.bottomSheet,
      this.backgroundColor,
      this.resizeToAvoidBottomInset = true,
      this.primary = true,
      this.state = const AppState(),
      this.disablePointer = false,
      this.forceAppBar = false,
      this.textUnderLoader,
      this.extendBodyBehindAppBar = false,
      this.error,
      this.disablePopOnBackIfLoading = false,
      this.loadingWidget,
      this.padding})
      : assert(primary != null),
        super(key: key);

  final Key scaffoldKey;
  final PreferredSizeWidget appBar;
  final EdgeInsetsGeometry padding;
  final WidgetBuilder builder;
  final WidgetBuilder noDataBuilder;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final List<Widget> persistentFooterButtons;
  final Widget drawer;
  final Widget endDrawer;
  final Color backgroundColor;
  final Widget bottomNavigationBar;
  final Widget bottomSheet;
  final bool resizeToAvoidBottomInset;
  final bool primary;
  final AppState state;
  final bool disablePointer;
  final bool forceAppBar;
  final String textUnderLoader;
  final bool extendBodyBehindAppBar;
  final dynamic error;
  final bool disablePopOnBackIfLoading;
  final Widget loadingWidget;

  static TodlrNPScaffoldState of(BuildContext context, {bool nullOk = false}) {
    final TodlrNPScaffoldState result =
        context.findAncestorStateOfType<TodlrNPScaffoldState>();
    return result;
  }

  @override
  TodlrNPScaffoldState createState() => TodlrNPScaffoldState();
}

class TodlrNPScaffoldState extends State<TodlrNPScaffold> {
  bool _isSearching = false;

  bool get isSearching {
    return _isSearching;
  }

  List<Widget> _requestedActions;
  Widget _requestedAppbar;
  AppState _requestedState;

  bool _showBlur = false;

  set isSearching(bool value) {
    _isSearching = value;
    if (!value) {
      if (_requestedState?.onSearchChanged != null) {
        _requestedState.onSearchChanged(null);
      } else if (widget.state.onSearchChanged != null) {
        widget.state.onSearchChanged(null);
      }
    }
  }

  void requestAppBarRefresh(PreferredSizeWidget appbar,
      {AppState appState, bool forceAppbar = false}) {
    _requestedState = appState;
    bool hasSearch = appState?.hasSearch ?? false;
    bool hadAppbar = _requestedAppbar != null;
    bool requestingAppbar = appbar != null;
    if (hadAppbar != requestingAppbar) refreshState();
    if (forceAppbar) {
      _requestedAppbar = appbar;
    } else {
      _requestedAppbar = null;
    }
  }

  void refreshState() {
    var state = TodlrNPScaffold.of(context);
    if (state != null) {
      state.refreshState();
    } else {
      Future.delayed(const Duration(milliseconds: 16)).then((_) {
        if (mounted) {
          setState(() {
            _requestedAppbar = _requestedAppbar;
          });
        } else {
          refreshState();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.floatingActionButton is TodlrMultiFloatingActionButton) {}
  }

  Widget _buildAppBar(BuildContext context) {
    TodlrNPScaffoldState state = TodlrNPScaffold.of(context);

    PreferredSizeWidget appbar;
    TodlrAppBar npAppBar = widget.appBar is TodlrAppBar ? widget.appBar : null;

    if (_requestedAppbar != null) {
      appbar = _requestedAppbar;
    } else if (_requestedActions != null &&
        _requestedActions.isNotEmpty &&
        npAppBar != null) {
      appbar = TodlrAppBar(
        backgroundColor: Colors.transparent,
        bottom: npAppBar.bottom,
        title: npAppBar.title,
        actions: _requestedActions,
        leading: npAppBar.leading,
        centerTitle: npAppBar.centerTitle,
        elevation: npAppBar.elevation,
      );
    } else if (widget.state.pageState == PageState.loaded &&
        widget.state.hasSearch &&
        state == null &&
        npAppBar != null) {
      appbar = TodlrAppBar(
        backgroundColor: npAppBar.backgroundColor,
        bottom: npAppBar.bottom,
        title: npAppBar.title,
        centerTitle: npAppBar.centerTitle,
        elevation: npAppBar.elevation,
      );
    } else {
      appbar = widget.appBar;
    }
    if (state != null) {
      state.requestAppBarRefresh(appbar,
          appState: widget.state, forceAppbar: widget.forceAppBar);
      return _EmptyAppBar();
    } else {
      return appbar;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffold = Theme(
      data: Theme.of(context),
      child: Scaffold(
        key: widget.scaffoldKey,
        appBar: _buildAppBar(context),
        body: Padding(
          padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20),
          child: AbsorbPointer(
            absorbing: widget.disablePointer,
            child: Stack(
              children: [
                SizedBox.expand(
                    child: TodlrPageStateWidget(
                  pageState: widget.state.pageState,
                  loadingWidget: widget.loadingWidget,
                  builder: widget.builder,
                  noDataBuilder: widget.noDataBuilder,
                  textUnderLoader: widget.textUnderLoader,
                  onRetry: widget.state.onRetry,
                  error: widget.error,
                  noDataMessage: widget.state.noDataMessage,
                )),
                _buildBlur(),
              ],
            ),
          ),
        ),
        floatingActionButton: widget.floatingActionButton,
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        floatingActionButtonAnimator: widget.floatingActionButtonAnimator,
        persistentFooterButtons: widget.persistentFooterButtons,
        drawer: widget.drawer,
        endDrawer: widget.endDrawer,
        bottomNavigationBar: widget.bottomNavigationBar,
        bottomSheet: widget.bottomSheet,
        backgroundColor: widget.backgroundColor ?? Colors.white,
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
        primary: widget.primary,
        extendBodyBehindAppBar: widget.extendBodyBehindAppBar,
      ),
    );

    return scaffold;
  }

  void toggleBlur() {
    setState(() {
      _showBlur = !_showBlur;
    });
  }

  Widget _buildBlur() {
    return Visibility(
      visible: _showBlur,
      child: GestureDetector(
        // onTap: toggleBlur,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _willPop() async {
    if (widget.disablePopOnBackIfLoading &&
        widget.state?.pageState == PageState.loading) return false;

    if (isSearching) {
      _stopSearching();
      return false;
    }
    return true;
  }

  void _stopSearching() {
    setState(() {
      isSearching = false;
    });
  }
}

// holds page state properties
class AppState {
  final PageState pageState;

  /// to show no data default widget, if null doesn't appear
  final String noDataMessage;

  /// to show search button, it's added at the end of the actions
  final bool hasSearch;
  final ValueChanged<String> onSearchChanged;

  /// when an error is showing, a retry button will be display
  final VoidCallback onRetry;

  /// when the keyboard done button for the search textfield is pressed
  final VoidCallback onSearchSubmit;

  // final String query;

  const AppState({
    this.pageState = PageState.loaded,
    this.noDataMessage = '',
    this.hasSearch = false,
    this.onSearchChanged,
    this.onSearchSubmit,
    this.onRetry,
  });
}

class _EmptyAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  Size get preferredSize => const Size(0, 0);
}
