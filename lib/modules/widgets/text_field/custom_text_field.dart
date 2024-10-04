import 'package:flutter/material.dart';

import '../../../constant.dart';

class CustomTextField extends StatefulWidget {
  final void Function(String?)? onChanged;
  final void Function()? onTap;
  final void Function(String?)? onSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validate;
  final Widget? prefixIcon;
  final IconData? suffixIcon;
  final double? width;
  final double? height;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? leftPadding;
  final double? rightPadding;
  final TextInputType? inputType;
  final String? label;
  final String? hint;
  final int? lines;
  final double? labelSize;
  final bool? secureText;
  final double? radius;
  final bool? isEnabled;
  final bool? autofocus;
  final Color? color;
  final Color? hintColor;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    this.onChanged,
    this.validate,
    this.prefixIcon,
    this.suffixIcon,
    this.width,
    this.height,
    this.inputType,
    this.label,
    this.hint,
    this.lines,
    this.labelSize,
    this.secureText,
    this.radius,
    this.onTap,
    this.onSubmitted,
    this.isEnabled = true,
    this.controller,
    this.horizontalPadding,
    this.verticalPadding,
    this.rightPadding,
    this.leftPadding,
    this.color,
    this.hintColor,
    this.onSaved,
    this.autofocus,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isHidden = true;

  void _visibility() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: widget.verticalPadding ?? 0,
          horizontal: widget.horizontalPadding ?? 0),
      child: Container(
        width: widget.width,
        margin: EdgeInsets.only(
            left: widget.leftPadding ?? 0,
            right: widget.rightPadding ?? 0,
            top: 0,
            bottom: 0),
        height: widget.height,
        child: GestureDetector(
          onTap:  (){
      FocusManager.instance.primaryFocus!.unfocus();
      },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: TextFormField(

              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: widget.controller,
              onFieldSubmitted: widget.onSubmitted,
              onTap: widget.onTap,
              maxLines: widget.lines ?? 1,
              style: const TextStyle(color: kPrimaryColor, fontSize: 12),
              obscureText: widget.suffixIcon == Icons.lock_outline
                  ? _isHidden
                  : (widget.secureText ?? false), //widget.secureText ?? false,
              cursorColor: kPrimaryColor,
              keyboardType: widget.inputType ?? TextInputType.multiline,
              validator: widget.validate,
              onSaved: widget.onSaved,
              autofocus: widget.autofocus ?? false,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 9),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 9),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 9),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 9),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
                errorStyle: const TextStyle(
                  fontSize: 10,
                ),
                errorMaxLines: 4,
                contentPadding: const EdgeInsets.only(
                    right: 20, top: 8.0, bottom: 8.0, left: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius ?? 9.0),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
                filled: true,
                fillColor: widget.color ?? const Color(0xFFFFFFFF),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon == Icons.lock_outline
                    ? GestureDetector(
                        onTap: _visibility,
                        child: Align(
                          alignment: Alignment.center,
                          child: _isHidden
                              ? const Icon(Icons.visibility_off_outlined,
                                  color: kPrimaryColor, size: 20)
                              : const Icon(Icons.visibility_outlined,
                                  color: kPrimaryColor, size: 20),
                        ),
                      )
                    : Icon(widget.suffixIcon, color: kPrimaryColor, size: 20),
                suffixIconConstraints:
                    const BoxConstraints(maxHeight: 39, maxWidth: 49),
                labelText: widget.label,
                labelStyle: TextStyle(
                  fontSize: widget.labelSize,
                  color: kPrimaryColor,
                ),
                hintStyle:
                    TextStyle(fontSize: 12, color: widget.hintColor ?? kGryColor),
                hintText: widget.hint,
              ),
              onChanged: widget.onChanged,
            ),
          ),
        ),
      ),
    );
  }
}
