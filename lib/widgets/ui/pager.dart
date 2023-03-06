import 'package:flutter/material.dart';

typedef PageItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
);

class Pager<T> extends StatelessWidget {
  const Pager({
    required Key key,
    required this.items,
    required this.builder,
    this.onRefresh,
  }) : super(key: key);

  final List<T> items;
  final PageItemBuilder<T> builder;
  final RefreshCallback? onRefresh;

  Widget buildRefreshableList(BuildContext context, List<T> items) {
    return RefreshIndicator(
      onRefresh: onRefresh!,
      child: buildList(context, items),
    );
  }

  Widget buildList(BuildContext context, List<T> items) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return builder(context, item);
      },
      separatorBuilder: (context, index) {
        return const Divider(
          height: 0.5,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return onRefresh != null
        ? buildRefreshableList(
            context,
            items,
          )
        : buildList(
            context,
            items,
          );
  }
}
