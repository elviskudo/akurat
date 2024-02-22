import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AccountAppBar extends StatelessWidget {
  const AccountAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 280,
      pinned: true,
      collapsedHeight: 180,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Colors.grey[200],
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: CachedNetworkImage(
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/14052859?v=4',
                  placeholder: (context, url) => Shimmer.fromColors(
                    baseColor: Colors.grey[200]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.white,
                    ),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                'Silahkan login terlebih dahulu untuk menggunakan fitur ini.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).unselectedWidgetColor,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(
                    color: Theme.of(context).unselectedWidgetColor,
                  ),
                ),
                foregroundColor: Theme.of(context).unselectedWidgetColor,
              ),
              onPressed: () {},
              child: const Text('Login'),
            ),
          ],
        ),
      ),
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      bottom: const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.bookmark_outline), text: 'Bookmark'),
          Tab(
            icon: Icon(Icons.notifications_outlined),
            text: 'Notifikasi',
          ),
        ],
      ),
    );
  }
}
