import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TopicsChipLoading extends StatelessWidget {
  const TopicsChipLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      child: const Chip(label: Text('Topic')),
    );
  }
}
