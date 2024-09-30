
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/core/dio_helper/dio_helper.dart';
import 'package:ghena_alshaam/modules/bloc/model/cities_model.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';

import '../../../core/state/base_state.dart';

class CitiesCubit extends Cubit<BaseState> {
  CitiesCubit() : super(const InitState());
  static CitiesCubit of(context) => BlocProvider.of(context);

  CitiesModel? citiesModel;

  Future<void> onGetCities(BuildContext context) async {
    emit(const LoadingState());
    try {
      final response = await DioHelper.get("cities");
      citiesModel = CitiesModel.fromJson(response.data);
      print(response.data);
    } catch (e) {
      showSnackBar(context, "خطأ في الإتصال");
    }
    emit(const InitState());
  }
}
