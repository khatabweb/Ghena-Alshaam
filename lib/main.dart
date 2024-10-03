import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/core/navigation/custom_navigator.dart';
// import 'package:ghena_alshaam/modules/bloc/cubit/cart_cubit.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/cities_cubit.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/contact_us_cubit.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/make_offer_cubit.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/make_order_cubit.dart';
import 'package:ghena_alshaam/modules/setting_screens/splash/view.dart';
import 'constant.dart';
import 'core/app_storage/app_storage.dart';
import 'core/dio_helper/dio_helper.dart';
import 'modules/bloc/cubit/slider_text_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await AppStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ContactCubit()),
        // BlocProvider(create: (_) => CartCubit()),
        BlocProvider(create: (_) => MakeOrderCubit()),
        BlocProvider(create: (_) => SliderTextCubit()),
        BlocProvider(create: (_) => CitiesCubit()),
        BlocProvider(create: (_) => MakeOfferCubit()),
      ],
      child: MaterialApp(
        title: 'Ghena Alshaam',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: onGenerateRoute,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          fontFamily: "Cairo",
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: kGreenColor,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle:
                TextStyle(fontSize: 12, height: 2, fontFamily: "Cairo-Bold"),
            unselectedLabelStyle:
                TextStyle(fontSize: 12, height: 2, fontFamily: "Cairo-Regular"),
          ),
        ),
        home: const SplashView(),
      ),
    );
  }
}
