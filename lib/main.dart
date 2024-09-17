import 'package:expense_app/data/local_data/dbhelper.dart';
import 'package:expense_app/ui_pages/add_exp_page.dart';
import 'package:expense_app/ui_pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui_pages/bottom_nav_provider.dart';
import 'package:expense_app/ui_pages/bottomnav_page.dart';
import 'package:expense_app/ui_pages/login_page.dart';
import 'package:expense_app/ui_pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(BlocProvider(
      create: (context)=>ExpenseBloc(dBhelper: DBhelper.getInstance()),
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=>BottomNavProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Expense App',
        home: SplashPage(),
      ),
    );
  }
}



