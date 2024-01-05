import 'package:flutter/material.dart';

import '../../../features/headline/headline_view.dart';
import 'widgets/home_tab_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const SingleChildScrollView(
        primary: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            HeadlineCarousel(),
            HomeTabSection(
              title: 'Berita Terkini',
              child: Text('Berita Terkini Vertical List'),
            ),
            HomeTabSection(
              title: 'Editor\'s Pick',
              child: Text('Editor\'s Pick Carousel'),
            ),
            HomeTabSection(
              title: 'Populer',
              child: Text('Populer Vertical List'),
            ),
          ],
        ),
      ),
    );
  }
}
