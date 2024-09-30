import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/core/dio_helper/dio_helper.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';

import '../../../core/state/base_state.dart';

class ContactCubit extends Cubit<BaseState> {
  ContactCubit() : super(const InitState());
  static ContactCubit of(context) => BlocProvider.of(context);

  TextEditingController nameController = TextEditingController();
  TextEditingController mailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  final contactKey = GlobalKey<FormState>();

  Future<void> onContactUs(BuildContext context) async {
    if (!contactKey.currentState!.validate()) return;

    emit(const LoadingState());
    try {
      final body = {
        "name": nameController.text,
        "email": mailController.text,
        "msg": messageController.text,
      };

      final Response response = await DioHelper.post("mail", body: body);

      if (response.statusCode == 200 && response.data["status"] == 1) {
        print(response.data);
        nameController.clear();
        mailController.clear();
        messageController.clear();
        // NavigatorHelper.pushReplacement(context, Home());
        showSnackBar(context, "تم الإرسال بنجاح", isSuccess: true);
      } else if (response.data["status"] == 0) {
        showSnackBar(context, response.data["msg"]);
      }
    } catch (e, s) {
      print(s);
      showSnackBar(context, "خطأ في الإتصال");
    }
    emit(const InitState());
  }
}
