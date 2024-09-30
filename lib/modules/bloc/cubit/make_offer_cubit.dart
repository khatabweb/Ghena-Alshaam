import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/core/dio_helper/dio_helper.dart';
import 'package:ghena_alshaam/core/navigation/custom_navigator.dart';
import 'package:ghena_alshaam/modules/main_screens/home/view.dart';
import 'package:ghena_alshaam/modules/main_screens/order_complete/view.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';
import '../../../core/state/base_state.dart';

class MakeOfferCubit extends Cubit<BaseState> {
  MakeOfferCubit() : super(const InitState());
  static MakeOfferCubit of(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController noteController = TextEditingController();
  String? cityName;
  String? payment_type;
  int? cityId;
  int? qty;
  double? lat;
  double? lng;

  final makeOfferKey = GlobalKey<FormState>();

  void cleanData(BuildContext context) {
    nameController.clear();
    phoneController.clear();
    addressController.clear();
    noteController.clear();
    cityId = null;
    qty = null;
    cityName = null;
    payment_type = null;
    lat = null;
    lng = null;
    NavigatorHelper.pushReplacement(context, Home());
  }

  Future<void> onMakeOffer(BuildContext context, int? offerId, int? price) async {
    if(!makeOfferKey.currentState!.validate()) return;
    qty != null ? print(qty!*price!) : print("qty null");
    emit(const LoadingState());
    try {
      final body = {
        "product_id[0]" : 0,
        "offer_id[0]" : offerId,
        "quantity[0]" : qty ?? 1,
        "cutting[0]" : "none",
        "wrapping[0]" : "none",
        "price[0]" : qty == null ? price : qty!*price!,
        "name": nameController.text,
        "phone": phoneController.text,
        "address": addressController.text,
        "order_type": "offer",
        "notes": noteController.text.isEmpty == true ? "بدون" : noteController.text,
        "lat": lat ?? 0.0,
        "lng": lng ?? 0.0,
      };
      print(body.toString());
      final Response response = await DioHelper.post("order-create", body: body);

      if (response.statusCode == 200 && response.data["status"] == "1") {
        print(response.data);
        NavigatorHelper.push(context, const OrderCompletedView());
        nameController.clear();
        phoneController.clear();
        addressController.clear();
        noteController.clear();
        cityId = null;
        qty = null;
        cityName = null;
        payment_type = null;
        lat = null;
        lng = null;
      } else if (response.statusCode != 200) {
        print(response.data.toString());
        showSnackBar(context, response.data["msg"]);
      }
    } catch (e, s) {
      print(s);
      print(e);
      showSnackBar(context, "خطأ في الإتصال");
    }
    emit(const InitState());
  }
}
