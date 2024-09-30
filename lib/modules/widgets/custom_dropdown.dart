import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghena_alshaam/constant.dart';
import 'package:ghena_alshaam/modules/widgets/custom_text.dart';

class CustomDropDown extends StatelessWidget {
  final List<DropdownMenuItem<dynamic>>? items;
  final void Function(dynamic)? onChanged;
  final String? hint;
  final dynamic value;
  const CustomDropDown({Key? key, required this.items, required this.onChanged, this.hint, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: const Color(0xFFC2C2C2), width: 1)
      ),
      child: Center(
        child: DropdownButton(
          hint: SingleText(text: hint, fontSize: 14),
          value: value,
          iconEnabledColor: kLightTextColor,
          icon: const Icon(CupertinoIcons.chevron_down),
          iconSize: 20,
          borderRadius: BorderRadius.circular(5),
          isDense: true,
          isExpanded: true,
          underline: const SizedBox(height: 0),
          items: items,
          onChanged: onChanged,
        ),
      ),
    );
  }
}