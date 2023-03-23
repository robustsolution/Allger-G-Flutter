import 'dart:async';
import 'dart:convert';

import 'package:allger/Pages/HelpPage/Styles/index.dart';
import 'package:allger/Pages/InformationPage/Styles/index.dart';
import 'package:allger/Pages/InformationPage/informationPage.dart';
import 'package:allger/Route/routes.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropDownBox extends StatefulWidget {
  Function onChange;
  Function? validator;
  List items;
  Widget hint;
  Icon? dropIcon;
  Color? errorColor;
  TextStyle? textStyle;
  TextStyle? hintStyle;
  Color? fillColor;
  Color? normalColor;
  Color? activeColor;
  String? initValue;
  DropDownBox(
      {Key? key,
      required this.onChange,
      this.validator,
      required this.items,
      required this.hint,
      this.dropIcon,
      this.normalColor,
      this.activeColor,
      this.errorColor,
      this.textStyle,
      this.hintStyle,
      this.fillColor,
      this.initValue})
      : super(key: key);

  @override
  _DropDownBoxState createState() => _DropDownBoxState();
}

class _DropDownBoxState extends State<DropDownBox> {
  final selectedItem = "fds";

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 54,
      width: double.infinity,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12),
      //   border: Border.all(
      //     width: 1,
      //     color: InformationPageColors.mainColor,
      //   ),
      // ),
      child: DropdownButtonFormField2<dynamic>(
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? Colors.transparent,
          counter: const SizedBox.shrink(),
          // border: InputBorder.none,
          // focusedBorder: InputBorder.none,
          // enabledBorder: InputBorder.none,
          // errorBorder: InputBorder.none,
          // disabledBorder: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.activeColor ?? Colors.blue,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.normalColor ?? Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.errorColor ?? const Color(0xFFE72C37),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),

          contentPadding:
              // const EdgeInsets.only(left: 20, bottom: 17, top: 17, right: 17),
              const EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: widget.normalColor ?? Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        value: widget.initValue ?? widget.items[0],
        isExpanded: true,
        hint: widget.hint,
        icon: widget.dropIcon ??
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.black54,
            ),
        // iconSize: 30,
        // buttonHeight: 80,
        buttonPadding: const EdgeInsets.only(left: 20, right: 10),
        // dropdownDecoration: BoxDecoration(
        //   // borderRadius: BorderRadius.circular(15),
        // ),
        dropdownMaxHeight: 300,

        items: widget.items
            .map(
              (item) => DropdownMenuItem<dynamic>(
                value: item,
                child: Text(
                  item.toString(),
                ),
              ),
            )
            .toList(),
        // value: selectedItem,
        validator: (value) {
          return widget.validator!(value);
          // if (value == null) {
          //   return 'Please select gender.';
          // }
        },
        onChanged: (value) {
          return widget.onChange(value);
          //Do something when changing the item if you want.
        },
        onSaved: (value) {
          // return widget.onSaved(value);
          // ss = value.text;
          // ss = value.toString();
        },
      ), //  DropdownButton<Item>(
      //   hint: itemWidget(widget.hint),
      //   value: selectedItem,
      //   onChanged: (value) {
      //     setState(() {
      //       selectedItem = value;
      //     });
      //   },
      //   items: widget.items.map((Item item) {
      //     return DropdownMenuItem<Item>(
      //       value: item,
      //       child: itemWidget(item),
      //     );
      //   }).toList(),
      // ),
    );
  }
}
