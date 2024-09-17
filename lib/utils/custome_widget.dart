import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

///Custom TextField..
class myTextFields extends StatelessWidget {
  TextEditingController? controller;
  String hinttxt;
  Icon? mIcons;
  double borderRadius;
  Color borderclr;
  TextInputType keyBoardType;
  myTextFields({this.controller,required this.hinttxt,this.borderRadius=11,this.borderclr=Colors.black,this.keyBoardType=TextInputType.text,this.mIcons});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyBoardType,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderclr)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: borderclr)
        ),
        hintText: hinttxt,
        suffixIcon: mIcons,
      ),
    );
  }
}

Widget mySizebox({double mheight=12,double mwidth=12}){
  return SizedBox(height: mheight,width:mwidth,);
}
