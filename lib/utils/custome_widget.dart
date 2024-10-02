import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'app_styling.dart';

///Custom TextField..
class myTextFields extends StatelessWidget {
   bool isBDark = false;
  TextEditingController? controller;
  String hinttxt;
  Icon? mIcons;
  double borderRadius;
  Color borderclr;
  int? maxlenght;
  TextInputType keyBoardType;

  myTextFields({this.controller,required this.hinttxt,this.borderRadius=11,this.borderclr=Colors.black,this.keyBoardType=TextInputType.text,this.mIcons,this.maxlenght});
  @override
  Widget build(BuildContext context) {
     isBDark = Theme.of(context).brightness==Brightness.dark;
    return TextField(
      controller: controller,
      keyboardType: keyBoardType,
      maxLength: maxlenght,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color:isBDark?Colors.white:borderclr)
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
           borderSide: BorderSide(color:isBDark?Colors.white:borderclr)
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

///Button..
class RoundedBatton extends StatelessWidget{
  String btnName;
  Color? btnColor;
  double boderRadius;
  VoidCallback callback;
  RoundedBatton({required this.btnName,this.btnColor,this.boderRadius=11,required this.callback});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: pinkColor(),
          minimumSize: Size(MediaQuery.of(context).size.width, 55),
          maximumSize: Size(MediaQuery.of(context).size.width, 55),

          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(boderRadius)),
          elevation: 11,
          shadowColor: pinkColor(),
        ),
        onPressed: callback,
        child: Text(
          btnName,
          style: myFonts16(myColor: Colors.white),
        ));
  }

}