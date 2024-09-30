import 'package:flutter/cupertino.dart';
import 'package:ghena_alshaam/core/dio_helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';
import '../../../core/state/base_state.dart';
import '../model/about_us_model.dart';

class AboutUsCubit extends Cubit<BaseState> {
  AboutUsCubit() : super(const InitState());
  static AboutUsCubit of(context) => BlocProvider.of(context);

  AboutModel? aboutModel;

  Future<void> onGetAbout(BuildContext context) async {
    emit(const LoadingState());
    try {
      final response = await DioHelper.get("about");
      aboutModel = AboutModel.fromJson(response.data);
      print(response.data);
    } catch (e) {
      showSnackBar(context, "خطأ في الإتصال");
    }
    emit(const InitState());
  }
}
