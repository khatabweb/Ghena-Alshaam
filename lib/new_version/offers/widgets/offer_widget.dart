import 'package:flutter/material.dart';
import 'package:ghena_alshaam/core/navigation/custom_navigator.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';
import 'package:ghena_alshaam/modules/widgets/cutom_network_image.dart';
import 'package:ghena_alshaam/new_version/offer_details/screens/offer_details_screen.dart';

import '../../../modules/bloc/model/offers_model.dart';

class OffersWidgets extends StatelessWidget {
  final String image;
  final String price;
  final String tittel;
  final Data? data;
  const OffersWidgets(
      {required this.image,
      required this.price,
      required this.tittel,
      Key? key,
      this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigatorHelper.push(context, OffersDetailsView(offer: data));
      },
      child: GridTile(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: AppNetworkImage(
              imageUrl:
                  "https://ghinaanalshshama.com/public/dash/assets/img/${image}",
              fit: BoxFit.fill),
        ),
        // Container(
        //   // width: MediaQuery.of(context).size.width * .9,
        //   // height: MediaQuery.of(context).size.width * .3,
        //   margin: EdgeInsets.all(8),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12),
        //     color: Colors.white,
        //     image: DecorationImage(
        //       image: NetworkImage(
        //         "https://ghinaanalshshama.com/public/dash/assets/img/${image}",
        //       ),
        //       fit: BoxFit.fill,
        //     ),
        //   ),
        // ),
        footer: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8))),
          // height: 60,
          child: GridTileBar(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * .5,
                  child: MainText(
                    text: "${tittel}",
                    maxLines: 3,
                    color: Colors.white,
                    textAlign: TextAlign.right,
                    fontSize: 12,
                    verticalPadding: 0,
                  ),
                ),
                MainText(
                  text: "${price} ر.س",
                  // maxLines: 3,
                  color: Colors.white,
                  textAlign: TextAlign.right,
                  fontSize: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
