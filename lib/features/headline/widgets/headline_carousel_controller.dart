import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../shared/article/article_model.dart';

class HeadlineCarouselController extends StatelessWidget {
  const HeadlineCarouselController({
    super.key,
    required CarouselController controller,
    required int current,
    required this.articles,
  })  : _controller = controller,
        _current = current;

  final CarouselController _controller;
  final int _current;
  final List<Article> articles;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: articles.map((headline) {
        final index = articles.indexOf(headline);
        return GestureDetector(
          onTap: () => _controller.animateToPage(index),
          child: Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _current == index
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor.withOpacity(0.4),
            ),
          ),
        );
      }).toList(),
    );
  }
}
