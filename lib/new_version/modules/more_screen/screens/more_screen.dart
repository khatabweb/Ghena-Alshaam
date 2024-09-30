import 'package:flutter/material.dart';
import 'package:share/share.dart';

import '../../../../constant.dart';
import '../../../../modules/setting_screens/about_us/view.dart';
import '../../../../modules/setting_screens/contact_us/view.dart';
import '../../../../modules/widgets/app_bar/app_bar.dart';
import '../../../../modules/widgets/custom_text.dart';
import '../../../../modules/widgets/webview_scaffold.dart';
import '../../../new_bar.dart';
import '../../MainScreen/view.dart';

class MoreScreen extends StatelessWidget {
  MoreScreen({Key? key}) : super(key: key);
  final List<NavMenuItem> navigationMenu = [
    NavMenuItem("الرئيسيه", (context) => pushFast(context, MainView())),
    NavMenuItem(
        "تعرف علينا", (context) => pushFast(context, const AboutUsView())),
    NavMenuItem(
        "اتصل بنا", (context) => pushFast(context, const ContactUsView())),
    NavMenuItem("مشاركه التطبيق", (context) {
      // Navigator.pop(context);
      Share.share(
          'https://play.google.com/store/apps/details?id=com.khatab.an');
    }),
    NavMenuItem(
        "قيم التطبيق",
        (context) => pushFast(
            context,
            const WebViewScaffold(
                "https://play.google.com/store/apps/details?id=com.khatab.an"))),
    NavMenuItem(
      "سياسة الخصوصية ",
      (context) => pushFast(
          context,
          WebViewScaffold(
            "https://www.freeprivacypolicy.com/live/c3758450-8d91-4f2b-b2de-301e32d3ace4",
          )),
    ),
  ];
  final List<IconData> navigationIconsMenu = [
    Icons.home,
    Icons.people_outline,
    Icons.phone,
    Icons.share,
    Icons.star_border,
    Icons.info,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldKey,
      // drawer: const CustomDrawer(),
      appBar: customAppBar(context, 'المزيد',
          showArrowBackIcon: false, showCart: true, showLogo: true),

      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: ListView.builder(
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    children: <Widget>[
                      Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: ListTile(
                          title: MainText(
                            text: navigationMenu[index].title,
                            color: kTextColor,
                            fontSize: MediaQuery.of(context).size.width * 0.05,
                          ),
                          leading: SizedBox(
                            width: 30,
                            height: 30,
                            child: Icon(
                              navigationIconsMenu[index],
                              color: kPrimaryColor,
                            ),
                          ),
                          onTap: () =>
                              navigationMenu[index].destination(context),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: navigationMenu.length,
            ),
          ),
          NewsBar()
        ],
      ),
    );
  }

  static void pushFast(BuildContext context, Widget w) {
    // Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return w;
    }));
  }
}

class NavMenuItem {
  String title;
  Function(BuildContext context) destination;

  NavMenuItem(this.title, this.destination);
}
