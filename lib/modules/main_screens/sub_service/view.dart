import 'package:flutter/material.dart';
import 'package:ghena_alshaam/core/navigation/custom_navigator.dart';
import 'package:ghena_alshaam/modules/bloc/model/all_services_model.dart';
import 'package:ghena_alshaam/modules/main_screens/order_details/view.dart';
import 'package:ghena_alshaam/modules/widgets/app_bar/app_bar.dart';
import 'package:ghena_alshaam/modules/widgets/center_message.dart';
// import 'package:ghena_alshaam/modules/widgets/custom_button.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:ghena_alshaam/modules/widgets/cutom_network_image.dart';
// import 'package:ghena_alshaam/modules/widgets/product_card/product_card.dart';

import '../../../constant.dart';
// import '../../setting_screens/drawer/drawer.dart';

class SubServiceView extends StatelessWidget {
  final Services? servicesModel;

  SubServiceView(this.servicesModel, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: customAppBar(context, "${servicesModel?.name}",
          showArrowBackIcon: true, showCart: true),
      body: servicesModel?.products?.isEmpty == true
          ? const CenterMessage("لا توجد منتجات حاليا")
          : ListView.builder(
              itemCount: servicesModel?.products?.length,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              itemBuilder: (context, index) {
                final product = servicesModel?.products?[index];
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.zero,
                      child: Row(
                        children: [
                          Flexible(
                            child: AppNetworkImage(
                              imageUrl: getNetworkImage("${product?.image}"),
                              width: width * 0.36,
                              height: width * 0.3,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleText(
                                  text: '${product?.name}',
                                  // textAlign: TextAlign.center,
                                  fontSize: 14,
                                ),
                                SizedBox(
                                  height: width * .1,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () => NavigatorHelper.push(
                                          context, OrderDetailsView(product)),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 15, vertical: 2),
                                        decoration: BoxDecoration(
                                            color: kGreenColor,
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: MainText(
                                          text: "اطلب الان",
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    SingleText(
                                        text: '${product?.price} ر.س',
                                        color: kGreenColor,
                                        // textDirection: TextDirection.rtl,
                                        fontSize: 14),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
