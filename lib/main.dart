import 'package:expense_app/data/local_data/dbhelper.dart';
import 'package:expense_app/ui_pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui_pages/bottom_nav_provider.dart';
import 'package:expense_app/ui_pages/splash_page.dart';
import 'package:expense_app/ui_pages/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=>ExpenseBloc(dBhelper: DBhelper.getInstance())),
        ChangeNotifierProvider(create: (context) => BottomNavProvider(),),
        ChangeNotifierProvider(create: (context) => ThemeProvider(),),
      ],
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    context.read<ThemeProvider>().prefGetValue();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expense App',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: context.watch<ThemeProvider>().getThemeValue()?ThemeMode.dark:ThemeMode.light,

      home: SplashPage(),
    );
  }
}



