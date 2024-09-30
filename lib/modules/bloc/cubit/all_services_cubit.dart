import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:ghena_alshaam/core/dio_helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';
import '../../../core/state/base_state.dart';
import '../model/all_services_model.dart';

class AllServicesCubit extends Cubit<BaseState> {
  AllServicesCubit() : super(const InitState());
  static AllServicesCubit of(context) => BlocProvider.of(context);

  AllServicesModel? allServicesModel;

  Future<void> onGetAllServices(BuildContext context) async {
    emit(const LoadingState());
    try {
      final response = await DioHelper.get("service");
      log("${response.data}");
      allServicesModel = AllServicesModel.fromJson(response.data);
      print(response.data);
    } catch (e) {
      showSnackBar(context, "خطأ في الإتصال");
    }
    emit(const InitState());
  }
}
