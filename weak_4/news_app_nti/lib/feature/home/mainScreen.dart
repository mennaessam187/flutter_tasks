import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app_nti/core/utils/colors.dart';
import 'package:news_app_nti/core/utils/icons.dart';
import 'package:news_app_nti/core/widget/nav_button_item.dart';
import 'package:news_app_nti/feature/bookMark/view/bookMarkScreen.dart';
import 'package:news_app_nti/feature/home/exploreScreen.dart';
import 'package:news_app_nti/feature/home/home_screen.dart';
import 'package:news_app_nti/feature/weather/view/wether_screen.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    ExploreScreen(),
    Bookmarkscreen(),
    WeatherScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        child: Container(
          decoration: BoxDecoration(color: AppColor.navnar),
          child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
                _pageController.jumpToPage(index);
              });
            },
            items: [
              SalomonBottomBarItem(
                icon: NavButtonItem(
                  currentIndex: _currentIndex,
                  itemIndex: 0,
                  text: "Home",
                  iconBuilder: (color) =>
                      Icon(Icons.home_outlined, color: Colors.black),
                ),
                title: const Text(""),
                selectedColor: Colors.white,
                unselectedColor: Colors.transparent,
              ),
              SalomonBottomBarItem(
                icon: NavButtonItem(
                  currentIndex: _currentIndex,
                  itemIndex: 1,
                  text: "Explore",
                  iconBuilder: (color) => SvgPicture.asset(Appicons.explore),
                ),
                title: const Text(""),
                selectedColor: Colors.white,
                unselectedColor: Colors.transparent,
              ),
              SalomonBottomBarItem(
                icon: NavButtonItem(
                  currentIndex: _currentIndex,
                  itemIndex: 2,
                  text: "Bookmark",
                  iconBuilder: (color) => SvgPicture.asset(Appicons.book),
                ),
                title: const Text(""),
                selectedColor: Colors.white,
                unselectedColor: Colors.transparent,
              ),
              SalomonBottomBarItem(
                icon: NavButtonItem(
                  currentIndex: _currentIndex,
                  itemIndex: 3,
                  text: "Weather",
                  iconBuilder: (color) => SvgPicture.asset(Appicons.weather),
                ),
                title: const Text(""),
                selectedColor: Colors.white,
                unselectedColor: Colors.transparent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
