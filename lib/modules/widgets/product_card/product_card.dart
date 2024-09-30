import 'package:flutter/material.dart';
import 'package:ghena_alshaam/modules/widgets/cutom_network_image.dart';

import '../../../constant.dart';
import '../custom_text.dart';

class ProductCard extends StatelessWidget {
  final String? name;
  final String? image;
  final VoidCallback? onTap;

  const ProductCard({Key? key, this.name, this.image, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Column(
            // alignment: Alignment.bottomCenter,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: AppNetworkImage(
                      imageUrl: getNetworkImage("$image"),
                      width: width,
                      height: height),
                ),
              ),
              Center(
                child: SingleText(
                  text: "$name",
                  color: kPrimaryColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
