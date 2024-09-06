import 'dart:ui';

import 'package:flutter/material.dart';

///App Constance Colors..

Color backColor({Color? myColor}){
  return myColor?? Color(0xffFFFFFF);
}

Color pinkColor({Color? myColor}){
  return myColor?? Color(0xffFE3F80);
}
Color whiteColor({Color? myColor}){
  return myColor?? Color(0xffFFFFFF);
}
Color blckColor({Color? myColor}){
  return myColor?? Color(0xff1F1D34);
}

Color posterColor({Color? myColor}){
  return myColor?? Color(0xff6574D3);
}




///Font Styling..
TextStyle myFonts18({FontWeight myFontWeight = FontWeight.normal,Color?myColor}){
  return TextStyle(
    fontSize: 18,
    fontWeight: myFontWeight,
    color: myColor??blckColor()

  );
}
TextStyle myFonts16({FontWeight myFontWeight = FontWeight.normal,Color?myColor}){
  return TextStyle(
    fontSize: 16,
    fontWeight: myFontWeight,
    color: myColor??blckColor()

  );
}
TextStyle myFonts11({FontWeight myFontWeight = FontWeight.normal,Color?myColor}){
  return TextStyle(
    fontSize: 11,
    fontWeight: myFontWeight,
    color: myColor??blckColor()

  );
}

