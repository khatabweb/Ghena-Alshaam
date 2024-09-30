import 'package:flutter/cupertino.dart';
import 'package:ghena_alshaam/core/dio_helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/modules/bloc/model/offers_model.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';
import '../../../core/state/base_state.dart';

class OffersCubit extends Cubit<BaseState> {
  OffersCubit() : super(const InitState());
  static OffersCubit of(context) => BlocProvider.of(context);

  OffersModel? offersModel;

  Future<void> onGetAllOffers(BuildContext context) async {
    emit(const LoadingState());
    try {
      final response = await DioHelper.get("offers");
      offersModel = OffersModel.fromJson(response.data);
      print(response.data);
    } catch (e) {
      showSnackBar(context, "خطأ في الإتصال");
    }
    emit(const InitState());
  }
}
