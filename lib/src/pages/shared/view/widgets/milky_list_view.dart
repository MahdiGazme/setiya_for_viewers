import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MilkyListView<T> extends StatefulWidget {
  MilkyListView({
    required this.itemBuilder,
    required this.items,
    this.prototypeItem,
    this.restorationId,
    this.semanticChildCount,
    this.physics,
    this.loadingWidget,
    this.cacheExtent,
    this.itemExtent,
    this.showLoading = false,
    this.primary,
    final ScrollController? controller,
    this.padding,
    this.onRefresh,
    this.onLoadMoreData,
    this.findChildIndexCallback,
    this.emptyWidget,
    this.clipBehavior = Clip.hardEdge,
    this.shrinkWrap = false,
    this.hasMoreData = false,
    this.scrollDirection = Axis.vertical,
    this.addRepaintBoundaries = true,
    this.addAutomaticKeepAlive = true,
    this.reverse = false,
    this.addSemanticIndexes = true,
    this.keyboardDismissBehavior = ScrollViewKeyboardDismissBehavior.onDrag,
    this.dragStartBehavior = DragStartBehavior.start,
    final Key? key,
  })  : controller = controller ?? ScrollController(),
        super(key: key);

  final Widget? prototypeItem;
  final String? restorationId;
  final int? semanticChildCount;
  final bool showLoading;
  final Widget? loadingWidget;
  final ScrollViewKeyboardDismissBehavior keyboardDismissBehavior;
  final DragStartBehavior dragStartBehavior;
  final ScrollPhysics? physics;
  final double? cacheExtent;
  final double? itemExtent;
  final bool addAutomaticKeepAlive;
  final bool reverse;
  final bool addSemanticIndexes;
  final bool? primary;
  final bool addRepaintBoundaries;
  final ScrollController controller;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;
  final Clip clipBehavior;
  final bool shrinkWrap;
  final List<T> items;
  final bool hasMoreData;
  final Future<void> Function()? onRefresh;
  final Future<void> Function()? onLoadMoreData;
  final int? Function(Key key)? findChildIndexCallback;
  final Widget? emptyWidget;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  @override
  State<MilkyListView<T>> createState() => _MilkyListViewState<T>();
}

class _MilkyListViewState<T> extends State<MilkyListView<T>> {
  bool showLoadMoreData = false;

  @override
  void initState() {
    controllerListener();
    super.initState();
  }

  @override
  Widget build(final BuildContext context) => _body();

  Widget _defaultEmptyWidget() => const Center(
        child: Text('موردی برای نمایش وجود ندارد'),
      );

  Widget _body() => widget.onRefresh != null
      ? _refreshIndicator()
      : widget.showLoading
          ? widget.loadingWidget ?? _defaultLoading()
          : widget.items.isEmpty
              ? widget.emptyWidget ?? _defaultEmptyWidget()
              : _listView();

  Widget _defaultLoading() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _refreshIndicator() => RefreshIndicator(
        onRefresh: widget.onRefresh!,
        child: widget.showLoading
            ? widget.loadingWidget ?? _defaultLoading()
            : widget.items.isEmpty
                ? refreshableEmptyWidget()
                : _listView(),
      );

  Widget refreshableEmptyWidget() => CustomScrollView(
        dragStartBehavior: widget.dragStartBehavior,
        reverse: widget.reverse,
        scrollDirection: widget.scrollDirection,
        clipBehavior: widget.clipBehavior,
        keyboardDismissBehavior: widget.keyboardDismissBehavior,
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: widget.emptyWidget ?? _defaultEmptyWidget(),
          ),
        ],
      );

  Widget _listView() => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          if (showLoadMoreData) const CircularProgressIndicator(),
          ListView.builder(
            physics: widget.physics ?? const AlwaysScrollableScrollPhysics(),
            itemExtent: widget.itemExtent,
            dragStartBehavior: widget.dragStartBehavior,
            cacheExtent: widget.cacheExtent,
            addSemanticIndexes: widget.addSemanticIndexes,
            addRepaintBoundaries: widget.addRepaintBoundaries,
            addAutomaticKeepAlives: widget.addAutomaticKeepAlive,
            controller: widget.controller,
            scrollDirection: widget.scrollDirection,
            shrinkWrap: widget.shrinkWrap,
            clipBehavior: widget.clipBehavior,
            findChildIndexCallback: widget.findChildIndexCallback,
            keyboardDismissBehavior: widget.keyboardDismissBehavior,
            primary: widget.primary,
            prototypeItem: widget.prototypeItem,
            restorationId: widget.restorationId,
            reverse: widget.reverse,
            semanticChildCount: widget.semanticChildCount,
            padding: widget.padding,
            itemCount: widget.items.length,
            itemBuilder: (final context, final index) =>
                widget.itemBuilder.call(context, widget.items[index], index),
          ),
        ],
      );

  void controllerListener() => widget.controller.addListener(
        () async {
          if (widget.hasMoreData &&
              _reachedToBottom &&
              showLoadMoreData == false) {
            setState(() {
              showLoadMoreData = true;
            });
            await widget.onLoadMoreData?.call();
            setState(() {
              showLoadMoreData = false;
            });
          }
        },
      );

  bool get _reachedToBottom =>
      widget.controller.position.maxScrollExtent ==
      widget.controller.position.pixels;
}
