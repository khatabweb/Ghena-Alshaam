import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghena_alshaam/constant.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/make_order_cubit.dart';
import 'package:ghena_alshaam/modules/bloc/model/all_services_model.dart';
import 'package:ghena_alshaam/modules/bloc/model/cart_model.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/custom_button.dart';
import 'package:ghena_alshaam/modules/widgets/custom_dropdown.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:ghena_alshaam/modules/widgets/cutom_network_image.dart';
import 'package:ghena_alshaam/modules/widgets/error_handler/error_snackbar.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';

class OrderDetailsView extends StatefulWidget {
  final Products? productModel;
  const OrderDetailsView(this.productModel, {Key? key}) : super(key: key);
  @override
  State<OrderDetailsView> createState() => _OrderDetailsViewState();
}

class _OrderDetailsViewState extends State<OrderDetailsView> {
  PickResult? selectedPlace;
  Color color = kLightTextColor;
  final makeOrderKey = GlobalKey<FormState>();

  int _qty = 1;

  String? selectedCutting;
  String? selectedCover;
  List<String?>? cutting = [
    'ارباع',
    'انصاف',
    'كامل',
    'ثلاجه',
    'تفصيل كبير',
    'تفصيل صغير',
  ];
  List<String?>? cover = ['اطباق مغلفه', 'اكياس'];
  String convertToEnglishNumbers(String number) {
    const arabicDigits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const englishDigits = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

    for (int i = 0; i < arabicDigits.length; i++) {
      if (number.contains(arabicDigits[i])) {
        number = number.replaceAll(arabicDigits[i], englishDigits[i]);
      }
    }

    return number;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cubit = MakeOrderCubit.of(context);
    // final cartCubit = CartCubit.of(context);

    return Scaffold(
      appBar: customAppBar(context, "المنتج", showCart: true),
      body: Container(
        height: height,
        width: width,
        // decoration: BoxDecoration(
        //     image: DecorationImage(
        //   image: AssetImage(getImage("back.jpg")),
        // )),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Form(
              key: makeOrderKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                      child: AppNetworkImage(
                    imageUrl: getNetworkImage("${widget.productModel?.image}"),
                    fit: BoxFit.fill,
                    height: height / 5,
                    width: width / 1.5,
                  )
                      // Container(
                      //   height: height / 5,
                      //   width: width / 1.5,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       image: DecorationImage(
                      //         image: NetworkImage(getNetworkImage(
                      //             "${widget.productModel?.image}")),
                      //         fit: BoxFit.fill,
                      //       )),
                      // ),
                      ),

                  MainText(
                      text: "${widget.productModel?.name}",
                      fontSize: 18,
                      verticalPadding: 10),
                  SingleText(
                      text: "${widget.productModel?.detail}", fontSize: 14),

                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 200,
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () => setState(() => _qty++),
                              child: const CircleAvatar(
                                backgroundColor: kPrimaryColor,
                                radius: 12,
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            MainText(
                                text: "$_qty",
                                horizontalPadding: 10,
                                fontSize: 18),
                            GestureDetector(
                              onTap: () {
                                if (_qty > 1) {
                                  setState(() => _qty--);
                                } else {
                                  setState(() => _qty = 1);
                                }
                              },
                              child: const CircleAvatar(
                                backgroundColor: kPrimaryColor,
                                radius: 12,
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      MainText(
                        text:
                            "${_qty * int.parse("${convertToEnglishNumbers(widget.productModel?.price!.split(" ").last ?? "0")}")} ر.س",
                        color: kPrimaryColor,
                        fontSize: 20,
                      ),
                    ],
                  ),

                  /// make order
                  // const Divider(height: 40),
                  const SingleText(text: "طرق التقطيع", fontSize: 14),
                  CustomDropDown(
                    hint: "اختر التقطيع",
                    value: selectedCutting,
                    items: cutting
                        ?.map(
                          (ele) => DropdownMenuItem(
                            child: SingleText(text: ele, fontSize: 14),
                            value: ele,
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() => selectedCutting = val);
                      cubit.cutting = val;
                    },
                  ),

                  const SizedBox(height: 15),
                  const SingleText(text: "طرق التغليف", fontSize: 14),
                  CustomDropDown(
                    hint: "اختر التغليف",
                    value: selectedCover,
                    items: cover
                        ?.map(
                          (ele) => DropdownMenuItem(
                            child: SingleText(text: ele, fontSize: 14),
                            value: ele,
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() => selectedCover = val);
                      cubit.wrapping = val;
                    },
                  ),

                  const Divider(height: 40),

                  // const SingleText(text: "الاسم", fontSize: 14),
                  // CustomTextField(
                  //   controller: cubit.nameController,
                  //   hint: "اسم المستخدم",
                  //   inputType: TextInputType.name,
                  //   validate: Validations.name,
                  //   verticalPadding: 5,
                  // ),

                  // const SizedBox(height: 15),
                  // const SingleText(text: "رقم الهاتف", fontSize: 14),
                  // CustomTextField(
                  //   controller: cubit.phoneController,
                  //   hint: "050xxxxxxx",
                  //   inputType: TextInputType.phone,
                  //   validate: Validations.phone,
                  //   verticalPadding: 5,
                  // ),

                  // const SizedBox(height: 15),
                  // const SingleText(text: "عنوانك", fontSize: 14),
                  // CustomTextField(
                  //   controller: cubit.addressController,
                  //   hint: "عنوانك بالتفصيل",
                  //   inputType: TextInputType.text,
                  //   validate: Validations.any,
                  //   verticalPadding: 5,
                  // ),

                  // const SizedBox(height: 15),
                  // const SingleText(text: "موقعك", fontSize: 14),
                  // CustomTextFieldTap(
                  //   verticalPadding: 5,
                  //   hintColor: color,
                  //   label: selectedPlace == null
                  //       ? "موقعك الحالي"
                  //       : selectedPlace!.formattedAddress,
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (_) => PlacePicker(
                  //           //AIzaSyBsGwp19k_0lr31Hnyos-OPLdJ9FwTO6k4
                  //           apiKey:
                  //               "AAAAjw9LARY:APA91bHFnz2FeLX80l_nv8svBtegN74hXp-iFsq3f9yO0lLs16ggEcSqGcgEPwHPUAzxJ39FCbPa5rjtMmL9yuz_1ZkZIFjKVSGWc5ZzG3pjwnh_fGIcXHoMzbDt52Sk_MzqWW9mZyst",
                  //           initialPosition: const LatLng(23.8859, 45.0792),
                  //           enableMyLocationButton: true,
                  //           selectInitialPosition: true,
                  //           useCurrentLocation: true,
                  //           onPlacePicked: (value) {
                  //             setState(() {
                  //               selectedPlace = value;
                  //               color = kPrimaryColor;
                  //             });
                  //             cubit.location = value.formattedAddress;
                  //             cubit.lat = value.geometry?.location.lat;
                  //             cubit.lng = value.geometry?.location.lng;
                  //             Navigator.of(context).pop();
                  //           },
                  //         ),
                  //       ),
                  //     );
                  //   },
                  // ),

                  // const SizedBox(height: 15),
                  // const SingleText(text: "اضف ملاحظات", fontSize: 14),
                  // CustomTextField(
                  //   controller: cubit.noteController,
                  //   hint: "ملاحظات",
                  //   inputType: TextInputType.text,
                  //   lines: 7,
                  //   verticalPadding: 5,
                  // ),

                  CustomButton(
                    text: "اضف للسلة",
                    topPadding: 20,
                    bottomPadding: 20,
                    onTap: () {
                      if (makeOrderKey.currentState!.validate()) {
                        cubit.cutting == null
                            ? showSnackBar(context, "طريقة التقطيع مطلوبة")
                            : cubit.wrapping == null
                                ? showSnackBar(context, "طريقة التغليف مطلوبة")
                                :
                                // cubit.location == null
                                //     ? showSnackBar(context, "برجاء تحديد موقعك")
                                //     :
                                cubit.addToCart(CartItemsModel(
                                    productId: widget.productModel?.id,
                                    qty: _qty,
                                    shredder: cubit.cutting,
                                    packaging: cubit.wrapping,
                                    image: widget.productModel?.image,
                                    name: widget.productModel?.name,
                                    price: widget.productModel?.price,
                                  ));
                        log("add to list :::: ${cubit.cartItems}");
                        // cartCubit.AddToCart(
                        //     context,
                        //     productFormData.Products(
                        //         packaging: cubit.wrapping,
                        //         productId: widget.productModel?.id,
                        //         qty: _qty,
                        //         shredder: cubit.cutting,
                        //         price: widget.productModel!.price,
                        //         image: widget.productModel?.image,
                        //         name: widget.productModel?.name));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
