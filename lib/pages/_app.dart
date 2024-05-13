import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:websafe_svg/websafe_svg.dart';

// import '../features/menu/menu_view.dart';
import '../features/topics/topics_view.dart';
import '../features/topics/widgets/topics_search_delegate.dart';
import 'state.dart';
import 'tabs/account/page.dart';
import 'tabs/page.dart';
import 'tabs/search/page.dart';
import 'tabs/topics/page.dart';

class Application extends ConsumerStatefulWidget {
  const Application({super.key});

  @override
  ConsumerState<Application> createState() => _ApplicationState();
}

class _ApplicationState extends ConsumerState<Application> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = ref.watch(pagesProvider);

    return Scaffold(
      appBar: AppBar(
        title: WebsafeSvg.asset('assets/logo.svg', height: 32.0),
        centerTitle: true,
        bottom: currentIndex == 0 ? const TopicsTabBar() : null,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: TopicsSearchDelegate(pageController: _pageController),
              );
            },
          ),
        ],
      ),
      // drawer: const AppDrawer(),
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        iconSize: 24.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
        type: BottomNavigationBarType.fixed,
        landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        onTap: (index) {
          _pageController.animateToPage(
            index,
            curve: Curves.easeInOut,
            duration: Durations.medium2,
          );
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.home),
            label: 'Beranda',
            tooltip: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.shapes),
            label: 'Topik',
            tooltip: 'Topik',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.search),
          //   label: 'Pencarian',
          //   tooltip: 'Pencarian',
          // ),
          BottomNavigationBarItem(
            icon: Icon(LucideIcons.user2),
            label: 'Akun',
            tooltip: 'Akun',
          ),
        ],
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            ref.read(pagesProvider.notifier).changePage(index);
          },
          children: [
            const IndexPage(),
            const TopicsPage(),
            SearchPage(pageController: _pageController),
            const AccountPage(),
          ],
        ),
      ),
    );
  }
}
