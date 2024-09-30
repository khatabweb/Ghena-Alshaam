import 'package:flutter/material.dart';

class CountryCode extends StatelessWidget {
  final String? countyCode;
  const CountryCode({Key? key, this.countyCode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 1,
          height: 50,
          color: Theme.of(context).dividerColor,
        ),
        Text(
          countyCode ?? "+966",
          textDirection: TextDirection.ltr,
          style:
          TextStyle(color: Theme.of(context).primaryColor, fontSize: 12),
        ),
        const SizedBox(),
      ],
    );
  }
}