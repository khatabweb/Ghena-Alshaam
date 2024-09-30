import 'package:flutter/cupertino.dart';
import 'package:ghena_alshaam/core/dio_helper/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/modules/bloc/model/our_way_model.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';
import '../../../core/state/base_state.dart';

class OurWayCubit extends Cubit<BaseState> {
  OurWayCubit() : super(const InitState());
  static OurWayCubit of(context) => BlocProvider.of(context);

  OurWayModel? ourWayModel;

  Future<void> onGetOurWay(BuildContext context) async {
    emit(const LoadingState());
    try {
      final response = await DioHelper.get("setting");
      ourWayModel = OurWayModel.fromJson(response.data);
      print(response.data);
    } catch (e) {
      showSnackBar(context, "خطأ في الإتصال");
    }
    emit(const InitState());
  }
}
