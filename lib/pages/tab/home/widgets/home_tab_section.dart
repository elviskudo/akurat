import 'package:flutter/material.dart';

class HomeTabSection extends StatelessWidget {
  const HomeTabSection({
    super.key,
    required this.title,
    this.child,
    this.withPadding = true,
  });

  final String title;
  final Widget? child;
  final bool withPadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: withPadding
          ? const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 24.0,
            )
          : const EdgeInsets.all(0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          child != null ? const SizedBox(height: 16.0) : const SizedBox(),
          child ?? const SizedBox(),
        ],
      ),
    );
  }
}
