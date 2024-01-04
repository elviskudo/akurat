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
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.white,
          child: const ListTile(
            title: Text(''),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
            ),
          ),
        );
      },
    );
  }
}
