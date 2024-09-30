import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ghena_alshaam/core/navigation/custom_navigator.dart';
// import 'package:ghena_alshaam/modules/bloc/cubit/cart_cubit.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/make_order_cubit.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:ghena_alshaam/new_version/cartScreen/screens/cart_screen.dart';

import '../../../constant.dart';
import '../../../core/state/base_state.dart';
import '../custom_Loading.dart';

PreferredSizeWidget? customAppBar(
  BuildContext context,
  String text, {
  final bool showArrowBackIcon = true,
  final Widget? title,
  final bool? showCart,
  final bool? showLogo,
}) {
  return PreferredSize(
    preferredSize: Size.fromHeight(90), //

    child: ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
      child: ColoredBox(
        color: kPrimaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      showArrowBackIcon == true
                          ? GestureDetector(
                              onTap: () => NavigatorHelper.pop(context),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    right: 20, left: 0, top: 20, bottom: 0),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 24,
                                  color: kGreenColor,
                                ),
                              ),
                            )
                          : Container(),
                      showLogo == true
                          ? Image.asset(
                              "assets/images/logo.png",
                              width: 80,
                              height: 50,
                              fit: BoxFit.fill,
                            )
                          : Container(),
                    ],
                  ),
                  // if (showDrawerIcon == true)
                  //   _drawerIcon(
                  //     context: context,
                  //     onPressed: onPressedDrawer,
                  //     color: backgroundColor == null ||
                  //             backgroundColor == kPrimaryColor
                  //         ? kGreenColor
                  //         : Colors.black,
                  //   ),

                  showCart == true
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Stack(
                            children: [
                              InkWell(
                                onTap: () =>
                                    NavigatorHelper.push(context, CartView()),
                                child: FaIcon(
                                  FontAwesomeIcons.cartShopping,
                                  color: kGreenColor,
                                ),
                              ),
                              BlocBuilder<MakeOrderCubit, BaseState>(
                                  builder: (context, state) {
                                final cubit = MakeOrderCubit.of(context);
                                return state is LoadingState
                                    ? const CustomLoading()
                                    : Transform.translate(
                                        offset: Offset(-5, -5),
                                        child: Container(
                                            child: MainText(
                                              color: Colors.white,
                                              
                                              text: cubit.cartItems == null
                                                  ? "0"
                                                  : cubit.cartItems.length.toString(),
                                              fontSize: 10,
                                            ),
                                            padding: const EdgeInsets.all(2),
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red)),
                                      );
                              })
                            ],
                          ),
                        )
                      : Container()
                ],
              ),
            ),
            // AppBar(
            //   backgroundColor: backgroundColor ?? kPrimaryColor,
            //   elevation: elevation ?? 0,
            //   titleSpacing: 0,
            //   leadingWidth: 72,
            //   centerTitle: true,

            //   /// leading
            //   leading: showArrowBackIcon == true
            //       ? GestureDetector(
            //           onTap: () => NavigatorHelper.pop(context),
            //           child: Container(
            //             margin: const EdgeInsets.only(
            //                 right: 20, left: 0, top: 15, bottom: 15),
            //             child: const Icon(
            //               Icons.arrow_back_ios,
            //               size: 18,
            // color: kGreenColor,
            //             ),
            //           ),
            //         )
            //       : const SizedBox(),

            //   /// title
            //   title: title ??
            //       MainText(text: text, fontSize: 18, color: kPrimaryColor),

            //   /// actions
            //   actions: [
            //     if (showDrawerIcon == true)
            //       _drawerIcon(
            //         context: context,
            //         onPressed: onPressedDrawer,
            //         color: backgroundColor == null ||
            //                 backgroundColor == kPrimaryColor
            //             ? kGreenColor
            //             : Colors.black,
            //       ),
            //     if (showCartIcon == true)
            //       GestureDetector(
            //         child: Container(
            //           height: 25,
            //           width: 25,
            //           margin: EdgeInsets.only(
            //             top: 15,
            //             bottom: 15,
            //             left: cartLeftPadding ?? 8,
            //             right: cartRightPadding ?? 8,
            //           ),
            //           child: Image.asset("assets/icons/cart.png",
            //               fit: BoxFit.contain),
            //         ),
            //         // onTap: () => NavigatorHelper.push(context, CartView()),
            //       ),
            //     if (showNotificationIcon == true)
            //       InkWell(
            //         child: Container(
            //           margin: const EdgeInsets.symmetric(
            //               vertical: 15, horizontal: 8),
            //           child: Image.asset("assets/icons/notifi.png",
            //               fit: BoxFit.fill),
            //         ),
            //         // onTap: () => NavigatorHelper.push(context, const NotificationView()),
            //       ),
            //     if (showNotificationIcon == true) const SizedBox(width: 10),
            //     actions ?? const SizedBox(),
            //   ],
            // ),

            title ??
                MainText(
                  text: text,
                  fontSize: 16,
                  color: kGreenColor,
                  verticalPadding: 8,
                )
          ],
        ),
      ),
    ),
  );
}

Widget _drawerIcon({
  BuildContext? context,
  void Function()? onPressed,
  Color? color,
}) {
  return InkWell(
    onTap: () {
      // print("mahsdmasds${onPressed()}");
      onPressed!();
    },
    child: Container(
      margin: const EdgeInsets.only(right: 20, left: 0, top: 25, bottom: 0),
      child: const Center(
          child: Icon(
        Icons.menu,
        size: 25,
        color: kGreenColor,
      )),
    ),
  );
}
