import 'package:flutter/material.dart';

import '../../../features/topics/widgets/topics_search_delegate.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    super.key,
    required this.pageController,
  });

  final PageController pageController;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300)).then((_) {
      showSearch(
        context: context,
        delegate: TopicsSearchDelegate(),
      ).then((_) {
        widget.pageController.jumpToPage(0);
      });
    });
  }

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
