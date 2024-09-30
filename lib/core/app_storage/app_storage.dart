import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get_storage/get_storage.dart';

import 'user_model.dart';

class AppStorage {
  static final GetStorage _box = GetStorage();

  static Future<void> init() async => await GetStorage.init();

  static void cacheToken(String value) => _box.write('token', value);

  static void cacheId(int id) => _box.write('id', id);

  static void cachePhone(String phone) => _box.write('phone', phone);

  static void cacheName(String name) => _box.write('name', name);

  static Future<void> cacheUser(UserModel user) async =>
      await _box.write('user', user.toJson());

  static UserModel get getUserModel => UserModel.fromJson(_box.read('user'));

  // static int get getId => getUserModel.data!.id!;

  static String get getToken => getUserModel.data!.token!;

  static bool get isLogged => _box.hasData('user');

  static String get getPhone => _box.read('phone');

  static String get getName => _box.read('name');

  static int get getId => _box.read('id');

  static Map<String, dynamic> getCartData() {
    var dataStr = _box.read('Cart');
    if (dataStr == null) return {};
    return json.decode(dataStr);
  }

  static void clearCartData() {
    var dataStr = _box.remove('Cart');
    // if (dataStr == null) return {};
    // return json.decode(dataStr);
  }

  static void setCartData({
    @required Map<String, dynamic>? data,
  }) {
    _box.write('Cart', json.encode(data));
  }

  static void signOut(BuildContext context) {
    _box.erase();
    // CustomNavigator.pushReplacement(context, SplashScreen(screen: OnBoardingView(), isBeginning: false));
  }
}
