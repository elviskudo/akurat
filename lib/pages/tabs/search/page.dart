import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      // child: Center(
      //   child: Text(
      //     'Tekan pada icon "Search" di pojok kanan atas untuk mencari artikel.',
      //     textAlign: TextAlign.center,
      //     style: Theme.of(context)
      //         .textTheme
      //         .bodySmall
      //         ?.copyWith(color: Theme.of(context).unselectedWidgetColor),
      //   ),
      // ),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
