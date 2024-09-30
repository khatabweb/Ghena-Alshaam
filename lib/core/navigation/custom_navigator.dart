import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Route<dynamic>? onGenerateRoute(RouteSettings settings) => null;

class NavigatorHelper{
  static BuildContext? currentContext = navigatorKey.currentContext;

  static Future push(BuildContext context, Widget screen){
    return Platform.isAndroid
        ? Navigator.push(context, MaterialPageRoute(builder: (_) => screen))
        : Navigator.push(context, CupertinoPageRoute(builder: (_) => screen));
  }

  static Future pushReplacement(BuildContext context, Widget screen){
    return Platform.isAndroid
        ? Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => screen), (route) => false)
        : Navigator.pushAndRemoveUntil(context, CupertinoPageRoute(builder: (_) => screen), (route) => false);
  }

  static void pop(BuildContext context){
    return Navigator.pop(context);
  }

}