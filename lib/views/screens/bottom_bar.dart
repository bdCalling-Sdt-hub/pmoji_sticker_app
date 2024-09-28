
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../utils/utils.dart';
import 'screens.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static final List _screen = [
    HomeScreen(),
    MyPmojisScreen(),
    PmojisCartScreen(),
    MyProfileScreen()
  ];

  void _itemIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screen.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        height: 100.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(24.r),
            //     topRight: Radius.circular(24.r)
            // )
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            ///---------------home---------------->
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 0 ? AppIcons.homeSelectIcons : AppIcons.homeUnSelectIcons,width: 24.w,height: 24.h,
              ),
              label: 'Home',
            ),

            ///---------------Liked Music---------------->
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 1 ? AppIcons.myPmojiSelectIcon : AppIcons.myPmojiUnSelectIcon,

              ),
              label: 'My Pmojis',
            ),

            ///---------------My Music---------------->
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 2 ?AppIcons.pmojiSelectIcon : AppIcons.pmojiUnSelectIcon,

              ),
              label: 'Pimoji Cart',
            ),

            ///---------------profile---------------->
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                _selectedIndex == 3 ? AppIcons.profileSelectIcon : AppIcons.profileUSelectIcon,
              ),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _itemIndex,
          iconSize: 20.h,
          selectedFontSize: 14.h,
          selectedLabelStyle: TextStyle(fontFamily: "ComicNeue-Light"),
          unselectedLabelStyle: TextStyle(fontFamily: "ComicNeue-Light"),
          selectedItemColor:AppColors.primaryColor,
          unselectedItemColor: Color(0xff6B6B6B),
          backgroundColor: Color(0xffEfF1EE),

        ),
      ),
    );
  }
}
