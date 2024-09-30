import 'package:flutter/material.dart';
import 'package:ghena_alshaam/modules/bloc/cubit/make_order_cubit.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';

import '../../../constant.dart';

class CartItemWidget extends StatefulWidget {
  // final Products product;
  final int index;
  final int? productId;
  late int? qty;
  final String? shredder;
  final String? packaging;
  final String? image;
  final String? name;
  final String? price;
  CartItemWidget({required this.index, Key? key, this.productId, this.qty, this.shredder, this.packaging, this.image, this.name, this.price}) : super(key: key);

  @override
  State<CartItemWidget> createState() => _CartItemWidgetState();
}

class _CartItemWidgetState extends State<CartItemWidget> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final cubit = MakeOrderCubit.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Card(
        child: Container(
          child: Row(children: [
            Container(
              height: height / 8,
              width: height / 8,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    image: NetworkImage(getNetworkImage("${widget.image}")),
                    fit: BoxFit.fill,
                  )),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MainText(
                  text: widget.name,
                  fontSize: 15,
                ),
                MainText(
                  text: widget.shredder,
                  fontSize: 15,
                ),
                MainText(
                  text: widget.packaging,
                  fontSize: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() => widget.qty = widget.qty! + 1);
                            cubit.increment(widget.index);
                          },
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
                            text: "${widget.qty}",
                            horizontalPadding: 10,
                            fontSize: 18),
                        GestureDetector(
                          onTap: () {
                            if (widget.qty! > 1) {
                              setState(() => widget.qty = widget.qty! - 1);
                              cubit.decrement(widget.index);
                            } else {
                              setState(() => widget.qty = 1);
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
                    SizedBox(
                      width: width / 4,
                    ),
                    InkWell(
                      onTap: () {
                        cubit.removeItem(widget.index);
                      },
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
