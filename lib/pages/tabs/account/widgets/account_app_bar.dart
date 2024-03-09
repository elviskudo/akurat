import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../signin/page.dart';
import '../../../state.dart';
import '../state.dart';

class AccountAppBar extends ConsumerWidget {
  const AccountAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(accountProvider.select((state) => state));

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
                  imageUrl: user != null
                      ? '${user.profilePhotoUrl}&size=${56}'
                      : 'https://avatars.githubusercontent.com/u/14052859?v=4',
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
            if (user?.name != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32)
                    .copyWith(bottom: 8),
                child: Text(
                  user!.name,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              )
            ],
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32)
                  .copyWith(bottom: 24),
              child: Text(
                user?.email ?? 'Silahkan login untuk menggunakan fitur ini.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).unselectedWidgetColor),
                textAlign: TextAlign.center,
              ),
            ),
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
              onPressed: () {
                if (user == null) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SigninPage(),
                    ),
                  );
                } else {
                  ref.read(accountProvider.notifier).logout();
                  ref.read(pagesProvider.notifier).changePage(0);
                }
              },
              child: Text(user != null ? 'Logout' : 'Login'),
            ),
          ],
        ),
      ),
      surfaceTintColor: Colors.transparent,
      automaticallyImplyLeading: false,
      bottom: const TabBar(
        tabs: [
          Tab(icon: Icon(Icons.bookmark_outline), text: 'Bookmark'),
          // Tab(
          //   icon: Icon(Icons.notifications_outlined),
          //   text: 'Notifikasi',
          // ),
        ],
      ),
    );
  }
}
