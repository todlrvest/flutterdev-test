// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tolr_app/components/todlr_error_switcher.dart';
import 'package:tolr_app/components/todlr_no_data.dart';
import 'package:tolr_app/utils/todlr_colors.dart';

typedef SegregationFunction<T> = bool Function(T value);

bool isNotEmpty(String s) => s != null && s.isNotEmpty && s != 'null';

const Color _kDefaultNavBarBorderColor = Color(0x4D000000);

const Border _kDefaultNavBarBorder = Border(
  bottom: BorderSide(
    color: _kDefaultNavBarBorderColor,
    width: 0.0, // One physical pixel.
    style: BorderStyle.solid,
  ),
);

class SelectionListBottomSheet<T> extends StatefulWidget {
  final List<T> items;
  final Widget Function(T) itemBuilder;
  final ValueChanged<T> onItemSelected;
  final String title;
  final bool hasSearch;
  final bool Function(T, String) searchMatcher;
  final Future<List<T>> itemsFuture;
  final bool shouldPop;
  final String searchHint;
  final String noDataMessage;
  final Map<String, SegregationFunction<T>> segregationMap;
  final TextStyle defaultSegregationTitleStyle;
  final EdgeInsets segregationTitlePadding;
  final Map<String, TextStyle> segregationTitlesStylesMap;
  final bool hideSegregationTitle;
  final Color seperatorColor;

  const SelectionListBottomSheet({
    Key key,
    this.items,
    this.itemsFuture,
    this.itemBuilder,
    this.onItemSelected,
    this.title,
    this.hasSearch = false,
    this.searchMatcher,
    this.shouldPop = true,
    this.segregationMap,
    this.searchHint,
    this.noDataMessage,
    this.defaultSegregationTitleStyle,
    this.segregationTitlePadding,
    this.segregationTitlesStylesMap,
    this.seperatorColor = Colors.grey,
    this.hideSegregationTitle = false,
  })  : assert(items != null || itemsFuture != null, "items cannot be null"),
        assert(itemBuilder != null, "itemBuilder cannot be null"),
        assert(onItemSelected != null, "onItemSelected cannot be null"),
        assert(title != null, "title cannot be null"),
        assert(
            hasSearch && searchMatcher != null ||
                !hasSearch && searchMatcher == null,
            "if search enabled, matcher cannot be null"),
        super(key: key);

  @override
  _SelectionListBottomSheetState<T> createState() =>
      _SelectionListBottomSheetState<T>();
}

class _SelectionListBottomSheetState<T>
    extends State<SelectionListBottomSheet<T>> {
  String _searchQuery;

  List<T> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.items ?? [];
  }

  TextStyle _getSegregationTitleStyle(String segregationTitle) {
    if (widget.segregationTitlesStylesMap == null) return null;
    return widget.segregationTitlesStylesMap[segregationTitle];
  }

  List<dynamic> get _segregatedItems {
    if (widget.segregationMap == null ||
        widget.segregationMap.isEmpty ||
        _filteredItems.isEmpty) {
      return _filteredItems;
    }
    List<dynamic> data = [];
    widget.segregationMap.forEach((title, segregationFunction) {
      List<T> itemsForKey = _filteredItems
          .where((element) => segregationFunction(element))
          .toList();
      if (itemsForKey != null && itemsForKey.isNotEmpty) {
        if (!widget.hideSegregationTitle) {
          data.add(Padding(
            padding: widget.segregationTitlePadding ??
                const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              title,
              style: _getSegregationTitleStyle(title) ??
                  widget.defaultSegregationTitleStyle ??
                  Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: textV1Colour),
            ),
          ));
        }
        data.addAll(itemsForKey);
      }
    });

    List remaining = _filteredItems
        .where((item) =>
            widget.segregationMap.values.firstWhere(
              (segregationFunction) => segregationFunction(item),
              orElse: () => null,
            ) ==
            null)
        .toList();
    if (remaining != null && remaining.isNotEmpty) data.addAll(remaining);
    return data;
  }

  List<T> get _filteredItems => (widget.hasSearch && isNotEmpty(_searchQuery))
      ? _items
          .where((item) => widget.searchMatcher(item, _searchQuery))
          .toList()
      : _items;

  Widget _buildTitle() {
    return Text(
      widget.title,
      key: Key(widget.title),
      style: Theme.of(context).textTheme.headline1.copyWith(
            color: Colors.black,
          ),
    );
  }

  OutlineInputBorder get _border => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(color: Colors.white, width: 0.0),
      );

  Widget _buildSearchBox() {
    return widget.hasSearch
        ? Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Container(
              color: Colors.white,
              child: TextFormField(
                key: const Key('search'),
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: Colors.black,
                    ),
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  hintText: isNotEmpty(widget.searchHint)
                      ? widget.searchHint
                      : 'search',
                  hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: Colors.grey,
                      ),
                  prefixIcon: const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Icon(
                      Icons.search,
                      color: Colors.black12,
                    ),
                  ),
                  border: _border,
                  focusedBorder: _border,
                  enabledBorder: _border,
                  disabledBorder: _border,
                ),
                onChanged: (searchQuery) => setState(() {
                  _searchQuery = searchQuery;
                }),
              ),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildItemsList() {
    List items = _segregatedItems;
    return CustomScrollView(
      shrinkWrap: true,
      controller: ModalScrollController.of(context),
      slivers: [
        SliverVisibility(
          visible: widget.hasSearch,
          sliver: SliverPadding(
            padding: const EdgeInsets.only(
              top: 18,
              left: 15,
              right: 15,
            ),
            sliver: SliverToBoxAdapter(
              child: _buildSearchBox(),
            ),
          ),
        ),
        SliverSafeArea(
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      InkWell(
                        onTap: items[index] is T
                            ? () {
                                if (widget.shouldPop ?? true) {
                                  Navigator.of(context).pop(items[index]);
                                }
                                widget.onItemSelected(items[index]);
                              }
                            : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: items[index] is Widget
                              ? items[index]
                              : widget.itemBuilder(items[index]),
                        ),
                      ),
                      // Divider(
                      //   height: 1,
                      //   color: widget.seperatorColor,
                      //   thickness: 1,
                      // ),
                    ],
                  ),
                );
              },
              childCount: items.length,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFutureBody() {
    double height = MediaQuery.of(context).size.height * 0.5;
    return FutureBuilder<List<T>>(
      future: widget.itemsFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return SizedBox(
            height: height,
            child: Center(
              child: ErrorSwitcher(
                message: 'generic_error',
                onRetry: () => setState(() {}),
              ),
            ),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data == null || snapshot.data.isEmpty) {
            return SizedBox(
              height: height,
              child: Center(
                child: TodlrNoData(widget.noDataMessage ?? 'no data'),
              ),
            );
          } else {
            _items = snapshot.data;
            return _buildItemsBody();
          }
        } else {
          return SizedBox(
            height: height,
            child: const Center(),
          );
        }
      },
    );
  }

  Widget _buildItemsBody() {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          padding: const EdgeInsetsDirectional.only(
            top: 10,
            bottom: 10,
            end: 18,
          ),
          transitionBetweenRoutes: false,
          middle: widget.hasSearch
              ? _buildTitle()
              : Padding(
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [_buildTitle()],
                  ),
                ),
          border: widget.hasSearch ? _kDefaultNavBarBorder : null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          trailing: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close_rounded),
          )),
      child: _buildItemsList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.itemsFuture != null ? _buildFutureBody() : _buildItemsBody();
  }
}
