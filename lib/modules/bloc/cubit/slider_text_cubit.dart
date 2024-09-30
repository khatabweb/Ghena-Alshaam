import 'package:flutter/cupertino.dart';
import 'package:ghena_alshaam/core/dio_helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';
import '../../../core/state/base_state.dart';
import '../model/slider_text_model.dart';

class SliderTextCubit extends Cubit<BaseState> {
  SliderTextCubit() : super(const InitState());
  static SliderTextCubit of(context) => BlocProvider.of(context);

  SliderTextModel? model;

  Future<void> onGetSliderText(BuildContext context) async {
    emit(const LoadingState());
    try {
      final response = await DioHelper.get("slider-text");
      model = SliderTextModel.fromJson(response.data);
      print(response.data);
    } catch (e) {
      showSnackBar(context, "خطأ في الإتصال");
    }
    emit(const InitState());
  }
}
