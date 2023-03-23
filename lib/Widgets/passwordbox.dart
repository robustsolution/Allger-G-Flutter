import 'package:allger/Helpers/aller_g_icons.dart';
import 'package:flutter/material.dart';

class PasswordBox extends StatefulWidget {
  PasswordBox({
    Key? key,
    required this.controller,
    required this.hint,
    required this.activeColor,
    required this.normalColor,
    this.validator,
    this.maxlength,
    this.errorColor,
    this.textStyle,
    this.hintStyle,
    this.iconColor,
    int? maxLength,
  }) : super(key: key);

  final TextEditingController controller;
  final String hint;
  final Color activeColor;
  final Color normalColor;
  Function? validator;
  int? maxlength;
  Color? iconColor;
  Color? errorColor;
  TextStyle? textStyle;
  TextStyle? hintStyle;
  @override
  _PasswordBoxState createState() => _PasswordBoxState();
}

class _PasswordBoxState extends State<PasswordBox> {
  bool _hide = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void onShow() {
    setState(() {
      _hide = !_hide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _hide,
      controller: widget.controller,
      style: widget.textStyle,
      validator: (value) {
        return widget.validator!(value);
      },
      maxLength: widget.maxlength ?? 50,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.transparent,
        counter: const SizedBox.shrink(),
        // border: InputBorder.none,
        // focusedBorder: InputBorder.none,
        // enabledBorder: InputBorder.none,
        // errorBorder: InputBorder.none,
        // disabledBorder: InputBorder.none,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.activeColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.normalColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        // errorBorder: OutlineInputBorder(
        //   borderSide: BorderSide(
        //     color: (widget.errorColor != null)
        //         ? widget.errorColor
        //         : Color(0xFFE72C37),
        //     width: 1,
        //   ),
        //   borderRadius: BorderRadius.circular(12),
        // ),

        suffixIcon: IconButton(
          onPressed: () {
            onShow();
          },
          icon: Icon(
            _hide ? AllerG.eye : AllerG.eye_off,
            size: 18,
            color: widget.iconColor,
          ),
        ),

        contentPadding:
            const EdgeInsets.only(left: 20, bottom: 17, top: 17, right: 17),
        hintText: widget.hint,
        hintStyle: widget.hintStyle,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.normalColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
