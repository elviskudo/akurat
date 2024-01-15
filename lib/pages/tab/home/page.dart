import 'package:flutter/material.dart';

import '../../../features/headline/headline_view.dart';
import 'widgets/editors_pick_list.dart';
import 'widgets/home_tab_section.dart';
import 'widgets/latest_list.dart';
import 'widgets/popular_list.dart';

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
            HomeTabSection(title: 'Berita Terkini', child: LatestList()),
            HomeTabSection(title: 'Pilihan Editor', child: EditorsPickList()),
            HomeTabSection(title: 'Populer', child: PopularList()),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
