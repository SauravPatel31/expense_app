

import 'package:flutter/material.dart';

///App Constance Colors..


Color pinkColor({Color? myColor}){
  return myColor?? Color(0xffFE3F80);
}

Color posterColor({Color myColor =  const Color(0xff6574D3)}){
  return myColor;
}






///Font Styling..
TextStyle myFonts18({FontWeight myFontWeight = FontWeight.normal,Color? myColor}){
  return TextStyle(
    fontSize: 18,
    fontWeight: myFontWeight,
    color: myColor

  );
}
TextStyle myFonts16({FontWeight myFontWeight = FontWeight.normal,Color? myColor}){
  return TextStyle(
    fontSize: 16,
    fontWeight: myFontWeight,
    color: myColor
  );
}
TextStyle myFonts11({FontWeight myFontWeight = FontWeight.normal,Color? myColor}){
  return TextStyle(
    fontSize: 11,
    fontWeight: myFontWeight,
    color: myColor

  );
}
TextStyle myFonts13({FontWeight myFontWeight = FontWeight.normal,Color? myColor}){
  return TextStyle(
    fontSize: 13,
    fontWeight: myFontWeight,
    color: myColor

  );
}

