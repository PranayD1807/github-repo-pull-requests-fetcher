import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:task_github_request_viewer/consts/app_color.dart';
import 'package:task_github_request_viewer/screens/home_screen.dart';
import 'package:task_github_request_viewer/screens/search_screen.dart';

// ignore: constant_identifier_names
enum PageType { Home, SEARCH, TRENDING, NOTIFICATION, MESSAGE }

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  int currentPage = 0;
  List<Widget> screens = [];
  PageController pageController = PageController();

  void onTabPressed(int value) {
    setState(() {
      currentPage = value;
    });
    pageController.jumpToPage(value);
  }

  @override
  void initState() {
    super.initState();
    screens = [
      HomeScreen(
        scaffoldKey: _key,
      ),
      SearchScreen(
        scaffoldKey: _key,
      ),
    ];
  }

  List<BottomNavigationBarItem> navBarItems = [
    const BottomNavigationBarItem(
      icon: FaIcon(
        FontAwesomeIcons.houseChimney,
      ),
      label: "Home",
      activeIcon: FaIcon(
        FontAwesomeIcons.houseChimney,
      ),
    ),
    const BottomNavigationBarItem(
      icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
      label: "Search",
      activeIcon: FaIcon(
        FontAwesomeIcons.magnifyingGlass,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const Drawer(
        child: Center(
          child: Text("Drawer"),
        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            currentPage = value;
          });
        },
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: navBarItems,
        currentIndex: currentPage,
        unselectedItemColor: Colors.blueGrey,
        selectedItemColor: AppColor.black,
        onTap: onTabPressed,
      ),
    );
  }
}
