import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppDrawerLoading extends StatelessWidget {
  const AppDrawerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: 100,
              height: 20,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
