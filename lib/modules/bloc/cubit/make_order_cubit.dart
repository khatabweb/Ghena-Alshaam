import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/core/app_storage/app_storage.dart';
import 'package:ghena_alshaam/core/dio_helper/dio_helper.dart';
import 'package:ghena_alshaam/core/navigation/custom_navigator.dart';
import 'package:ghena_alshaam/modules/bloc/model/cart_model.dart';
import 'package:ghena_alshaam/modules/main_screens/home/view.dart';
import 'package:ghena_alshaam/modules/main_screens/order_complete/view.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';

import '../../../core/state/base_state.dart';


class MakeOrderCubit extends Cubit<BaseState> {
  MakeOrderCubit() : super(const InitState());
  static MakeOrderCubit of(context) => BlocProvider.of(context);


  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String? cityId;
  String? cityName;
  String? cutting;
  String? wrapping;
  String? payment_type;
  String? location;
  double? lat;
  double? lng;


  List<CartItemsModel> cartItems = [];

  void cleanData() {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    noteController.clear();
    cutting = null;
    wrapping = null;
    location = null;
    lat = null;
    lng = null;
    cartItems.clear();
    NavigatorHelper.pushReplacement(NavigatorHelper.currentContext!, Home());
  }

  increment(int index) {
    emit(const LoadingState());
    cartItems[index].qty = cartItems[index].qty! + 1;
    emit(const InitState());
  }

  decrement(int index) {
    emit(const LoadingState());
    cartItems[index].qty = cartItems[index].qty! - 1;
    emit(const InitState());
  }

  void removeItem(int index) {
    emit(const LoadingState());
    cartItems.removeAt(index);
    emit(const InitState());
  }


  Future<void> addToCart(CartItemsModel product) async {
    emit(const LoadingState());
    try {
      cartItems.add(product);
      showSnackBar(NavigatorHelper.currentContext!, "تم الاضافة بنجاح", isSuccess: true);
    } catch (e) {
      print(e);
      showSnackBar(NavigatorHelper.currentContext!, "خطأ في الإتصال");
    }
    emit(const InitState());
  }


  Future<void> onMakeOrder() async {
    emit(const LoadingState());
    try {

      final Map<String, dynamic> data = {
        "name": nameController.text,
        "phone": phoneController.text,
        "address": addressController.text,
        "order_type": "product",
        "notes": noteController.text.isEmpty == true ? "بدون" : noteController.text,
        "lat": lat ?? 0.0,
        "lng": lng ?? 0.0,
      };

      for(int i = 0; i < cartItems.length; i++){
        data.addAll({
          "product_id[$i]" : cartItems[i].productId,
          "offer_id[$i]" : 0,
          "quantity[$i]" : cartItems[i].qty,
          "cutting[$i]" : cartItems[i].shredder,
          "wrapping[$i]" : cartItems[i].packaging,
          "price[$i]" : cartItems[i].qty! * double.parse("${cartItems[i].price}"),
        });
      }

      print("cart items :::  $data");

      final Response response = await DioHelper.post("order-create", body: data);

      if (response.statusCode == 200 && response.data["status"] == "1") {
        // print(response.data);
        NavigatorHelper.push(NavigatorHelper.currentContext!, const OrderCompletedView());
        AppStorage.clearCartData();
        nameController.clear();
        phoneController.clear();
        addressController.clear();
        noteController.clear();
        cutting = null;
        wrapping = null;
        location = null;
        lat = null;
        lng = null;
        cityName = null;
        cityId = null;
        cartItems.clear();
      } else if (response.statusCode != 200) {
        print(response.data.toString());
        showSnackBar(NavigatorHelper.currentContext!, response.data["msg"]);
      }
    } catch (e, s) {
      print(s);
      print(e);
      showSnackBar(NavigatorHelper.currentContext!, "خطأ في الإتصال");
    }
    emit(const InitState());
  }
}
