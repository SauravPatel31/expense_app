import 'package:flutter/material.dart';

class BottomNavProvider extends ChangeNotifier{
  int _selectedindex=0;

  void updateBottomPage(int index){
    _selectedindex=index;
    notifyListeners();
  }
  int getBottomPage(){
   return _selectedindex;
  }

}