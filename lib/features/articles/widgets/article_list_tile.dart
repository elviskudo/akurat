import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../pages/article/id/page.dart';
import '../../../pages/article/tag/page.dart';
import '../models/article.dart';

class ArticleListTile extends StatelessWidget {
  const ArticleListTile({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(id: article.id),
          ),
        );
      },
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: CachedNetworkImage(
              imageUrl: article.thumbUrl,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.section != null) ...[
            Theme(
              data: Theme.of(context).copyWith(
                visualDensity: VisualDensity.compact,
              ),
              child: ActionChip(
                onPressed: () {
                  if (article.section != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TagPage(
                          tag: article.section!.name,
                        ),
                      ),
                    );
                  }
                },
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                label: Text(article.section!.name),
                labelStyle: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: Colors.white),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ],
          Text(
            article.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      subtitle: Text(
        article.publishedDate,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: Colors.black54),
      ),
      trailing: article.pageviews != null
          ? Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(LucideIcons.eye, size: 16),
                const SizedBox(width: 4),
                Text(
                  article.pageviews!,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: Colors.black54),
                ),
              ],
            )
          : null,
    );
  }
}
