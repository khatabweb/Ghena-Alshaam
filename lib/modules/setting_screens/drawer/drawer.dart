import 'package:flutter/material.dart';
import 'package:ghena_alshaam/constant.dart';
import 'package:ghena_alshaam/modules/main_screens/home/view.dart';
import 'package:ghena_alshaam/modules/setting_screens/about_us/view.dart';
import 'package:ghena_alshaam/modules/setting_screens/contact_us/view.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:ghena_alshaam/modules/widgets/webview_scaffold.dart';
import 'package:share/share.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  List<NavMenuItem> navigationMenu = [
    NavMenuItem("الرئيسيه", (context) => pushFast(context, Home())),
    NavMenuItem(
        "تعرف علينا", (context) => pushFast(context, const AboutUsView())),
    NavMenuItem(
        "اتصل بنا", (context) => pushFast(context, const ContactUsView())),
    NavMenuItem("مشاركه التطبيق", (context) {
      Navigator.pop(context);
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
            // "https://www.freeprivacypolicy.com/live/c3758450-8d91-4f2b-b2de-301e32d3ace4",
            "https://www.freeprivacypolicy.com/live/21323d15-5dec-4c9a-a7b6-2ea2710da0e9"
          )),
    ),
  ];
  List<IconData> navigationIconsMenu = [
    Icons.home,
    Icons.people_outline,
    Icons.phone,
    Icons.share,
    Icons.star_border,
    Icons.info,
  ];

  static void pushFast(BuildContext context, Widget w) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return w;
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        child: Drawer(
          child: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    ListTile(
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
                      onTap: () => navigationMenu[index].destination(context),
                    ),
                  ],
                );
              },
              itemCount: navigationMenu.length,
            ),
          ),
        ),
      ),
    );
  }
}

class NavMenuItem {
  String title;
  Function(BuildContext context) destination;

  NavMenuItem(this.title, this.destination);
}
