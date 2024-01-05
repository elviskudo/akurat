import 'package:cached_query_flutter/cached_query_flutter.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'headline_repository.dart';
import 'widgets/headline_carousel_controller.dart';
import 'widgets/headline_carousel_item.dart';
import 'widgets/headline_carousel_loading.dart';

class HeadlineCarousel extends StatefulWidget {
  const HeadlineCarousel({super.key});

  @override
  State<HeadlineCarousel> createState() => _HeadlineCarouselState();
}

class _HeadlineCarouselState extends State<HeadlineCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return QueryBuilder(
      query: HeadlineRepository.getHeadlines(),
      builder: (context, state) {
        if (state.status == QueryStatus.loading || state.data == null) {
          return const HeadlineCarouselLoading();
        }

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 240,
                viewportFraction: 0.9,
                enableInfiniteScroll: false,
                enlargeCenterPage: true,
                autoPlay: true,
                aspectRatio: 2.0,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
              items: state.data!
                  .map((headline) => HeadlineCarouselItem(headline: headline))
                  .toList(),
            ),
            const SizedBox(height: 16),
            HeadlineCarouselController(
              controller: _controller,
              current: _current,
              articles: state.data!,
            ),
          ],
        );
      },
    );
  }
}
