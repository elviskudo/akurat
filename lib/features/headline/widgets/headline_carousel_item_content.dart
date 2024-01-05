import 'package:flutter/material.dart';

import '../../shared/article/article_model.dart';

class HeadlineCarouselItemContent extends StatelessWidget {
  const HeadlineCarouselItemContent({
    super.key,
    required this.headline,
  });

  final Article headline;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0.0,
      left: 0.0,
      right: 0.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.8),
              Colors.black.withOpacity(0.9),
            ],
            stops: const [0, 0.2, 0.6, 0.8],
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 20.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Theme(
              data: Theme.of(context).copyWith(
                visualDensity: VisualDensity.compact,
              ),
              child: ActionChip(
                side: BorderSide.none,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                ),
                onPressed: () {},
                label: Text(headline.section?.name ?? 'Headline'),
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 12.0,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              headline.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              headline.publishedDate,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.white.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
