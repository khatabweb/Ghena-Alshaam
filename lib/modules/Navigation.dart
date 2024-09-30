import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghena_alshaam/modules/setting_screens/about_us/view.dart';

import '../constant.dart';
import '../new_version/modules/MainScreen/view.dart';

import '../new_version/modules/more_screen/screens/more_screen.dart';
import '../new_version/offers/screens/offers_screen.dart';
import 'bloc/cubit/slider_text_cubit.dart';

class Navigation extends StatefulWidget {
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  PageController? _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 3);
    _currentIndex = 3;
    // final cartCubit = CartCubit.of(context);
    // cartCubit.onGetcart(context);
    BlocProvider.of<SliderTextCubit>(context).onGetSliderText(context);
  }

  @override
  void dispose() {
    _pageController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: Utils().innerDrawerKey(),
      // endDrawer: DrawerScreend(),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: [
            MoreScreen(),
            OffersView(),
            AboutUsView(),
            MainView(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          // elevation: 0,

          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
            _pageController!.jumpToPage(index);
          },
          unselectedFontSize: 14,
          selectedLabelStyle: TextStyle(
            color: kGreenColor,
          ),
          unselectedLabelStyle: TextStyle(
            color: kGryColor,
          ),
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: "المزيد",
              // backgroundColor: Colors.white,
              icon: deActiveIcon(FontAwesomeIcons.chartSimple),
              activeIcon: ActiveIcon(FontAwesomeIcons.chartSimple),
            ),
            BottomNavigationBarItem(
              label: "العروض",
              // backgroundColor: Colors.white,
              icon: deActiveIcon(FontAwesomeIcons.percent),
              activeIcon: ActiveIcon(FontAwesomeIcons.percent),
            ),
            BottomNavigationBarItem(
              label: "تعرف علينا",
              // backgroundColor: Colors.white,
              icon: deActiveIcon(FontAwesomeIcons.addressCard),
              activeIcon: ActiveIcon(FontAwesomeIcons.addressCard),
            ),
            BottomNavigationBarItem(
              label: "الرئيسية",
              // backgroundColor: Colors.white,
              icon: deActiveIcon(FontAwesomeIcons.house),
              activeIcon: ActiveIcon(FontAwesomeIcons.house),
            ),
          ]),
    );
  }

  Widget ActiveIcon(IconData image) {
    return Icon(
      image,
      color: kGreenColor,
      size: 20,
    );
  }

  Widget deActiveIcon(IconData image) {
    return Icon(
      image,
      color: kGryColor,
      size: 20,
    );
  }
}
