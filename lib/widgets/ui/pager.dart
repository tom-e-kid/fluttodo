import 'package:flutter/material.dart';

typedef PageItemBuilder<T> = Widget Function(
  BuildContext context,
  T item,
);

class Pager<T> extends StatelessWidget {
  const Pager({
    Key? key,
    required this.items,
    required this.builder,
    this.onRefresh,
    this.dividerHeight,
  }) : super(key: key);

  final List<T> items;
  final PageItemBuilder<T> builder;
  final RefreshCallback? onRefresh;
  final double? dividerHeight;

  Widget buildRefreshableList(BuildContext context, List<T> items) {
    return RefreshIndicator(
      onRefresh: onRefresh!,
      child: buildList(context, items),
    );
  }

  Widget buildList(BuildContext context, List<T> items) {
    return ListView.separated(
      physics: const AlwaysScrollableScrollPhysics(),
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
        return dividerHeight != null
            ? Divider(
                height: dividerHeight,
              )
            : const SizedBox(
                height: 0,
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
