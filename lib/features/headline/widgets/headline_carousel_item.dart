import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../pages/article/[id]/page.dart';
import '../../articles/models/article.dart';
import 'headline_carousel_item_content.dart';
import 'headline_carousel_loading.dart';

class HeadlineCarouselItem extends StatelessWidget {
  const HeadlineCarouselItem({
    super.key,
    required this.headline,
  });

  final Article headline;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticleDetailPage(id: headline.id),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0, 0),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 240.0,
                    child: CachedNetworkImage(
                      imageUrl: headline.photoUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return const HeadlineCarouselLoading();
                      },
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  HeadlineCarouselItemContent(headline: headline),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
