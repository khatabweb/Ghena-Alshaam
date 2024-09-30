import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghena_alshaam/constant.dart';
import 'package:ghena_alshaam/core/state/base_state.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/cities_cubit.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/custom_Loading.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

import '../../../core/validate/validation.dart';
import '../../../modules/bloc/cubit/make_order_cubit.dart';
import '../../../modules/widgets/center_message.dart';
import '../../../modules/widgets/custom_button.dart';
import '../../../modules/widgets/custom_dropdown.dart';
import '../../../modules/widgets/error_handler/error_snackbar.dart';
import '../../../modules/widgets/text_field/custom_text_field.dart';
import '../../../modules/widgets/text_field/text_field_tap.dart';
import '../widgets/cart_item_widget.dart';

class ConfirmOrderView extends StatefulWidget {
  ConfirmOrderView({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderView> createState() => _ConfirmOrderViewState();
}

class _ConfirmOrderViewState extends State<ConfirmOrderView> {
  PickResult? selectedPlace;

  Color color = kLightTextColor;

  final makeOrderKey = GlobalKey<FormState>();
  String? SelectedpaymentType;

  double total = 0.0;

  @override
  void initState() {
    BlocProvider.of<CitiesCubit>(context).onGetCities(context);
    super.initState();
  }

  List<String?>? paymentType = ['الدفع عند الاستلام'];
  @override
  Widget build(BuildContext context) {
    final makeOrderCubit = MakeOrderCubit.of(context);
    return Scaffold(
      appBar: customAppBar(
        context,
        'اتمام الطلب',
        showArrowBackIcon: true,

        // showCart: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(),
        child: BlocBuilder<MakeOrderCubit, BaseState>(
          builder: (context, state) {
            final cubit = MakeOrderCubit.of(context);
            total = 0.0;

            for (int i = 0; i < cubit.cartItems.length; i++) {
              total += (cubit.cartItems[i].qty! * double.parse(cubit.cartItems[i].price!));
            }

            return state is LoadingState
                ? const CustomLoading()
                : cubit.cartItems == [] || cubit.cartItems.isEmpty
                    ? CenterMessage("لا توجد منتجات حاليا")
                    : Directionality(
                        textDirection: TextDirection.rtl,
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Form(
                            key: makeOrderKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                /// product list
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: cubit.cartItems.length,
                                  itemBuilder: (context, index) {
                                    var ele = cubit.cartItems[index];
                                    return CartItemWidget(
                                      index: index,
                                      qty: ele.qty,
                                      productId: ele.productId,
                                      image: ele.image,
                                      name: ele.name,
                                      packaging: ele.packaging,
                                      price: ele.price,
                                      shredder: ele.shredder,
                                    );
                                  },
                                ),
                                const Divider(height: 20),
                                Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      children: [
                                        MainText(text: "المجموع : ", fontSize: 16),
                                        MainText(text: "${total}"),
                                      ],
                                    ),
                                  ),
                                ),
                                const SingleText(text: "المدن", fontSize: 14),
                                BlocBuilder<CitiesCubit, BaseState>(
                                  builder: (context, state) {
                                    final city_cubit =
                                    CitiesCubit.of(context);
                                    return state is LoadingState
                                        ? const CustomLoading()
                                        : city_cubit.citiesModel == null
                                            ? Center(
                                                child: MainText(
                                                text:
                                                    "حدث خطأ ما يرجي المحاولة مرة اخري",
                                                fontSize: 15,
                                              ))
                                            : CustomDropDown(
                                                hint: "اختر المدينة",
                                                value:
                                                    makeOrderCubit.cityName,
                                                items: city_cubit
                                                    .citiesModel!.data
                                                    ?.map(
                                                      (ele) =>
                                                          DropdownMenuItem(
                                                        child: SingleText(
                                                            text: ele.city,
                                                            fontSize: 14),
                                                        value: ele.city,
                                                      ),
                                                    )
                                                    .toList(),
                                                onChanged: (val) {
                                                  print("value    ${val}");
                                                  // setState(() => selectedCover = val);
                                                  makeOrderCubit.cityName =
                                                      val.toString();

                                                  for (int i = 0;
                                                      i <
                                                          city_cubit
                                                              .citiesModel!
                                                              .data!
                                                              .length;
                                                      i++) {
                                                    if (city_cubit
                                                            .citiesModel!
                                                            .data![i]
                                                            .city ==
                                                        val.toString()) {
                                                      makeOrderCubit.cityId =
                                                          city_cubit
                                                              .citiesModel!
                                                              .data![i]
                                                              .id
                                                              .toString();
                                                    }
                                                  }
                                                  print(
                                                      makeOrderCubit.cityId);
                                                  setState(() {});
                                                },
                                              );
                                  },
                                ),
                                const Divider(height: 20),
                                const SingleText(text: "الاسم", fontSize: 14),
                                CustomTextField(
                                  controller: makeOrderCubit.nameController,
                                  hint: "اسم المستخدم",
                                  inputType: TextInputType.name,
                                  validate: Validations.name,
                                  verticalPadding: 5,
                                ),
                                const SizedBox(height: 15),
                                const SingleText(
                                    text: "رقم الهاتف", fontSize: 14),
                                CustomTextField(
                                  controller: makeOrderCubit.phoneController,
                                  hint: "050xxxxxxx",
                                  inputType: TextInputType.phone,
                                  validate: Validations.phone,
                                  verticalPadding: 5,
                                ),
                                const SizedBox(height: 15),
                                const SingleText(
                                    text: "عنوانك", fontSize: 14),
                                CustomTextField(
                                  controller:
                                      makeOrderCubit.addressController,
                                  hint: "عنوانك بالتفصيل",
                                  inputType: TextInputType.text,
                                  validate: Validations.any,
                                  verticalPadding: 5,
                                ),
                                const SizedBox(height: 15),
                                const SingleText(text: "موقعك", fontSize: 14),
                                CustomTextFieldTap(
                                  verticalPadding: 5,
                                  hintColor: color,
                                  label: selectedPlace == null
                                      ? "موقعك الحالي"
                                      : selectedPlace!.formattedAddress,
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PlacePicker(
                    
                                          //AIzaSyBsGwp19k_0lr31Hnyos-OPLdJ9FwTO6k4
                                          //AIzaSyBedHW8DNb7CXNjHjdf0MB4DNU51E20VW0
                                          apiKey:
                                              "AIzaSyAyhVG7B9FUmg-urb3TZBtDSTB2aXHVFCg",
                                          initialPosition:
                                              const LatLng(24.660623, 46.780575),
                                          enableMyLocationButton: true,
                                          selectInitialPosition: true,
                                          useCurrentLocation: true,
                                          onPlacePicked: (value) {
                                            setState(() {
                                              selectedPlace = value;
                                              color = kPrimaryColor;
                                            });
                                            makeOrderCubit.location =
                                                value.formattedAddress;
                                            makeOrderCubit.lat =
                                                value.geometry?.location.lat;
                                            makeOrderCubit.lng =
                                                value.geometry?.location.lng;
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 15),
                                const SingleText(
                                    text: "وسيلة الدفع", fontSize: 14),
                                CustomDropDown(
                                  hint: "اختر وسية الدفع",
                                  value: SelectedpaymentType,
                                  items: paymentType
                                      ?.map(
                                        (ele) => DropdownMenuItem(
                                          child: SingleText(
                                              text: ele, fontSize: 14),
                                          value: ele,
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (val) {
                                    setState(() => SelectedpaymentType = val);
                                    makeOrderCubit.payment_type = val;
                                  },
                                ),
                                const SizedBox(height: 15),
                                const SingleText(
                                    text: "اضف ملاحظات", fontSize: 14),
                                CustomTextField(
                                  controller: makeOrderCubit.noteController,
                                  hint: "ملاحظات",
                                  inputType: TextInputType.text,
                                  lines: 7,
                                  verticalPadding: 5,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20),
                                  child:
                                      BlocBuilder<MakeOrderCubit, BaseState>(
                                    builder: (context, state) {
                                      return state is LoadingState
                                          ? const CustomLoading()
                                          : Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceAround,
                                              children: [
                                                CustomButton(
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2.3,
                                                  text: "إلغاء الطلب",
                                                  isFrame: true,
                                                  onTap: () =>
                                                      MakeOrderCubit.of(
                                                              context)
                                                          .cleanData(),
                                                ),
                                                CustomButton(
                                                  width:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2.3,
                                                  text: "إتمام الشراء",
                                                  onTap: () {
                                                    if (makeOrderKey
                                                        .currentState!
                                                        .validate()) {
                                                      if (makeOrderCubit
                                                              .cityId ==
                                                          null) {
                                                        showSnackBar(context,
                                                            "فضلا قم بإدخال المدينة");
                                                      }
                                                      if (makeOrderCubit
                                                              .payment_type ==
                                                          null) {
                                                        showSnackBar(context,
                                                            "فضلا قم بإدخال وسيلة الدفع");
                                                      }
                                                      MakeOrderCubit.of(context).onMakeOrder();
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
          },
        ),
      ),
    );
  }
}
