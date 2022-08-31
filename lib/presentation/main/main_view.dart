import 'package:advance_course_flutter/presentation/main/home/home_page.dart';
import 'package:advance_course_flutter/presentation/main/notification_page.dart';
import 'package:advance_course_flutter/presentation/main/search_page.dart';
import 'package:advance_course_flutter/presentation/main/settings_page.dart';
import 'package:advance_course_flutter/presentation/resources/color_manger.dart';
import 'package:advance_course_flutter/presentation/resources/strings_manger.dart';
import 'package:advance_course_flutter/presentation/resources/values_manger.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {

  List<Widget> pages =[
    HomePage(),
    SearchPage(),
    NotificationPage(),
    SettingsPage(),
  ];

  List<String> titles =[
    AppStrings.home.tr(),
    AppStrings.search.tr(),
    AppStrings.notification.tr(),
    AppStrings.settings.tr(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[_currentIndex],
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorManger.lightGrey,
              spreadRadius: AppSize.s1,
            ),
          ],
        ),
        child: BottomNavigationBar(
          selectedItemColor: ColorManger.primary,
          unselectedItemColor: ColorManger.grey,
          currentIndex: _currentIndex,
          onTap: onTap,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppStrings.home.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.search),
              label: AppStrings.search.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              label: AppStrings.notification.tr(),
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppStrings.settings.tr(),
            ),
          ],
        ),
      ),
    );
  }

  onTap(int index){
    setState(() {
      _currentIndex = index;
    });
  }
}
