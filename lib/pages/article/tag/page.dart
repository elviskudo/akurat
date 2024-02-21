import 'package:flutter/material.dart';

import '../../tabs/topics/slug/page.dart';

class TagPage extends StatelessWidget {
  const TagPage({super.key, required this.tag});

  final String tag;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tag[0].toUpperCase() + tag.substring(1)),
      ),
      body: TopicsDetailPage(tag: tag),
    );
  }
}
