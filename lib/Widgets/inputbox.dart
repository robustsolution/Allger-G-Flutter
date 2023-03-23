import 'package:flutter/material.dart';

Widget InputBox({
  required TextEditingController controller,
  required String hint,
  required Icon icon,
  required Color activeColor,
  required Color normalColor,
  Function? validator,
  Color? errorColor,
  TextStyle? textStyle,
  TextStyle? hintStyle,
  int? maxLength,
  Color? fillColor,
}) {
  return TextFormField(
    controller: controller,
    // focusNode: ,
    style: textStyle,
    // onChanged: (text) {
    //   controller.text = text;
    // },
    // onSubmitted: (text) {

    // },
    // autofocus: true,
    validator: (value) {
      return validator!(value);
    },
    maxLength: maxLength ?? 50,

    decoration: InputDecoration(
      filled: true,
      fillColor: (fillColor != null) ? fillColor : Colors.transparent,
      counter: const SizedBox.shrink(),
      // border: InputBorder.none,
      // focusedBorder: InputBorder.none,
      // enabledBorder: InputBorder.none,
      // errorBorder: InputBorder.none,
      // disabledBorder: InputBorder.none,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: activeColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: normalColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: errorColor ?? const Color(0xFFE72C37),
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),

      suffixIcon: icon,

      contentPadding:
          const EdgeInsets.only(left: 20, bottom: 17, top: 17, right: 17),
      hintText: hint,
      hintStyle: hintStyle,
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: normalColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
