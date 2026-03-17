import 'package:flutter/material.dart';
import 'package:otc_app/app.dart';

import 'paging_mixin.dart';
import 'pull_refresh_control.dart';
import 'package:easy_refresh/easy_refresh.dart';

/// 快速构建 `ListView` 形式的分页列表
/// 其他详细参数查看 [ListView]
class SpeedyPagedList<T> extends StatelessWidget {
  const SpeedyPagedList({
    super.key,
    required this.controller,
    required this.itemBuilder,
    this.scrollController,
    this.padding,
    this.header,
    this.footer,
    this.locatorMode = false,
    this.refreshOnStart = true,
    this.startRefreshHeader,
    double? itemExtent,
    this.emptyWidget,
  })  : _separatorBuilder = null,
        _itemExtent = itemExtent;

  const SpeedyPagedList.separator({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required IndexedWidgetBuilder separatorBuilder,
    this.scrollController,
    this.padding,
    this.header,
    this.footer,
    this.locatorMode = false,
    this.refreshOnStart = true,
    this.startRefreshHeader,
    this.emptyWidget,
  })  : _separatorBuilder = separatorBuilder,
        _itemExtent = null;

  final PagingMixin<T> controller;

  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  final Header? header;
  final Footer? footer;

  final bool refreshOnStart;
  final Header? startRefreshHeader;
  final bool locatorMode;

  /// 参照 [ScrollView.controller].
  final ScrollController? scrollController;

  /// 参照 [ListView.itemExtent].
  final EdgeInsetsGeometry? padding;

  /// 参照 [ListView.separator].
  final IndexedWidgetBuilder? _separatorBuilder;

  /// 参照 [ListView.itemExtent].
  final double? _itemExtent;

  final Widget? emptyWidget;

  @override
  Widget build(BuildContext context) {
    return PullRefreshControl(
      pagingMixin: controller,
      header: header ??
          MaterialHeader(
            color: context.appColors.primary,
          ),
      footer: footer,
      refreshOnStart: refreshOnStart,
      startRefreshHeader: startRefreshHeader,
      locatorMode: locatorMode,
      emptyWidgetBuilder: emptyWidget != null
          ? (context, physics) {
              return CustomScrollView(
                physics: physics,
                controller: scrollController,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return emptyWidget!;
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              );
            }
          : null,
      childBuilder: (context, physics) {
        return _separatorBuilder != null
            ? ListView.separated(
                key: ValueKey(controller.items.hashCode),
                physics: physics,
                padding: padding,
                controller: scrollController,
                itemCount: controller.itemCount,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return itemBuilder.call(context, index, item);
                },
                separatorBuilder: _separatorBuilder!,
              )
            : ListView.builder(
                key: ValueKey(controller.items.hashCode),
                physics: physics,
                padding: padding,
                controller: scrollController,
                itemExtent: _itemExtent,
                itemCount: controller.itemCount,
                itemBuilder: (context, index) {
                  final item = controller.items[index];
                  return itemBuilder.call(context, index, item);
                },
              );
      },
    );
  }
}

/// 快速构建 `GridView` 形式的分页列表
/// 其他详细参数查看 [GridView]
class SpeedyPagedGrid<T> extends StatelessWidget {
  const SpeedyPagedGrid({
    super.key,
    required this.controller,
    required this.itemBuilder,
    required this.gridDelegate,
    this.scrollController,
    this.padding,
    this.header,
    this.footer,
    this.locatorMode = false,
    this.refreshOnStart = true,
    this.startRefreshHeader,
  });

  final PagingMixin controller;
  final Widget Function(BuildContext context, int index, T item) itemBuilder;

  final Header? header;
  final Footer? footer;

  final bool refreshOnStart;
  final Header? startRefreshHeader;
  final bool locatorMode;

  /// 参照 [ScrollView.controller].
  final ScrollController? scrollController;

  /// 参照 [ListView.itemExtent].
  final EdgeInsetsGeometry? padding;

  /// 参照 [GridView.gridDelegate].
  final SliverGridDelegate gridDelegate;

  @override
  Widget build(BuildContext context) {
    return PullRefreshControl(
      pagingMixin: controller,
      header: header,
      footer: footer,
      refreshOnStart: refreshOnStart,
      startRefreshHeader: startRefreshHeader,
      locatorMode: locatorMode,
      childBuilder: (context, physics) {
        return GridView.builder(
          physics: physics,
          padding: padding,
          controller: scrollController,
          gridDelegate: gridDelegate,
          itemCount: controller.itemCount,
          itemBuilder: (context, index) {
            final item = controller.items[index];
            return itemBuilder.call(context, index, item);
          },
        );
      },
    );
  }
}
