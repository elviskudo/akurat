import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';

import '../../../../features/articles/models/article_detail.dart';

class ArticleDetailAppBar extends StatelessWidget {
  const ArticleDetailAppBar({
    // ignore: unused_element
    super.key,
    required this.shouldShowTitle,
    required this.articleDetail,
  });

  final bool shouldShowTitle;
  final ArticleDetail articleDetail;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 240,
      pinned: true,
      iconTheme: IconThemeData(
        color: shouldShowTitle ? Colors.black : Colors.white,
      ),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 16,
        ),
        centerTitle: true,
        title: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: shouldShowTitle ? 1 : 0,
          child: WebsafeSvg.asset(
            'assets/logo.svg',
            height: 32.0,
          ),
        ),
        background: CachedNetworkImage(
          imageUrl: articleDetail.photoUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
