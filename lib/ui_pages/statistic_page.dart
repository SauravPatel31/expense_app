import 'dart:math';

import 'package:expense_app/ui_pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui_pages/bloc/expense_state.dart';
import 'package:expense_app/utils/app_styling.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../data/models/category_model.dart';
import '../data/models/expense_model.dart';
import '../data/models/filtered_expense_model.dart';
import '../utils/app_const_data.dart';

class StatiSticPage extends StatefulWidget {
  @override
  State<StatiSticPage> createState() => _StatiSticPageState();
}

class _StatiSticPageState extends State<StatiSticPage> {
  List<FilteredExpenseModel> allExpenseData=[];

  List<Color> piColors=[
     Colors.pink,
    Colors.deepPurple,
    Colors.green,
    Colors.deepOrange,
    Colors.blueAccent,
    Colors.teal,
    Colors.indigo,
    Colors.brown,
    Colors.red,
    Color(0xff283593),
    Color(0xff00695B),
    Color(0xff0277BD),
    Color(0xffFF8E01),
    Color(0xffF85181),
    Color(0xff01828F),

  ];
  DateFormat mFormat = DateFormat.yMMMd();
  int i=0;
  String selectedMenuItem = "Day";
  int touchedIndex=0;
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Statistic"),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            margin: EdgeInsets.all(5),
            width: 150,
            decoration: BoxDecoration(
              //color: Color(0xffEEF1FC),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    width: 1,
                    color: isDark ? Colors.white : Colors.black)),
            child: DropdownButton(
              value: selectedMenuItem,
              icon: Icon(
                Icons.filter_alt_outlined,
                size: 26,
              ),
              //dropdownColor: Color(0xffEEF1FC),
              isExpanded: true,
              underline: Container(),
              items: AppConstData.sfilteredExp.map((e) {
                return DropdownMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              onChanged: (value) {
                selectedMenuItem = value!;
                setState(() {
                  if (value == AppConstData.sfilteredExp.toList()[0]) {
                    AppConstData.mFormat =DateFormat.yMMMd();
                  }
                  if (value == AppConstData.sfilteredExp.toList()[1]) {
                    AppConstData.mFormat = DateFormat.yMMM();
                  }
                  if (value == AppConstData.sfilteredExp.toList()[2]) {
                    AppConstData.mFormat = DateFormat.y();
                  }
                  if(value==AppConstData.sfilteredExp.toList()[3]){
                    AppConstData.mFormat = DateFormat.EEEE();
                  }


                });
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              ///Expense Title Text and  Week DropdownMenu ..
              Text(
                "Expense Breakdown",
                style: myFonts18(myFontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 10,
              ),

              ///Bar Chart...
              Container(
                width: double.infinity,
                height: 250,
                //color: Colors.pinkAccent,
                child: BlocBuilder<ExpenseBloc, ExpenseState>(
                  builder: (_, state) {
                    if (state is LoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is LoadedState) {
                      var allData = AppConstData.filterExpense(state.mExp);
                      if (state.mExp.isNotEmpty) {
                        List<BarChartGroupData> mBars = [];

                        for (int i = 0; i < allData.length; i++) {
                          mBars.add(BarChartGroupData(x: i, barRods: [
                            BarChartRodData(
                                toY: allData[i].totalAmt.toDouble(),
                                width: 20,
                                borderRadius: BorderRadius.zero,
                                color: Colors.pink)
                          ]));
                        }
                        return BarChart(BarChartData(
                          barGroups: mBars,
                          alignment: BarChartAlignment.spaceBetween,
                        ));
                      } else {
                        return Center(
                          child: Lottie.asset("assets/lottie/barchart.json"),
                        );
                      }
                    }
                    return Container();
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),

              ///Spending Title Text ..
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Spending Details",
                          style: myFonts18(myFontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text("${"Your expenses are divided into $i categories"}",
                          style: myFonts11(
                              myColor: Colors.grey,
                              myFontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),

              ///Pi chart..
              BlocBuilder<ExpenseBloc, ExpenseState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is LoadedState) {
                    var allData = AppConstData.filterExpense(state.mExp);

                    if (state.mExp.isNotEmpty) {
                      List<PieChartSectionData> piData = [];
                      for (i = 0; i < allData.length; i++) {
                        piData.add(PieChartSectionData(
                          title:allData[i].title,
                          radius:touchedIndex==i? 90:80 ,
                          color:piColors[i],
                          badgeWidget:touchedIndex==i?CircleAvatar(
                              radius: 30,
                              child: Text(allData[i].totalAmt.toString())):null ,
                          badgePositionPercentageOffset: 1.1,
                          titlePositionPercentageOffset: 0.3,

                        ));
                      }
                      return Container(
                        width: 300,
                        height: 300,
                        margin: EdgeInsets.symmetric(horizontal: 50),
                        child: PieChart(

                          PieChartData(
                            sections: piData,
                            sectionsSpace: 2,
                            titleSunbeamLayout: true,
                              pieTouchData: PieTouchData(
                                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                                  if(pieTouchResponse!=null&&pieTouchResponse.touchedSection!=null){
                                    setState(() {
                                      touchedIndex=pieTouchResponse.touchedSection!.touchedSectionIndex;
                                    });
                                  }

                                },
                              ),
                          ),
                          swapAnimationDuration: Duration(milliseconds: 800),
                          swapAnimationCurve: Curves.linearToEaseOut,
                        ),
                      );
                    }
                    else{
                      return Center(child: Lottie.asset("assets/lottie/piechart.json",width: 300));
                    }

                  }
                  return Container();
                },
              ),


            ],
          ),
        ),
      ),
    );

  }
  void filteredExpCat(List<ExpenseModel> mExpense){
    allExpenseData.clear();
    for(CategoryModel eachCat in AppConstData.mCategory){
      num catamt=0.0;
      List<ExpenseModel> eachExpData=[];
      for(ExpenseModel eachExp in mExpense){
        if(eachExp.cat_id==eachCat.catid){
          eachExpData.add(eachExp);
          if(eachExp.etype=="Debit"){
            catamt-=eachExp.eamt;
          }
          else{
            catamt+=eachExp.eamt;
          }
        }
      }
      if(eachExpData.isNotEmpty){
        allExpenseData.add(FilteredExpenseModel(title: eachCat.catName, totalAmt: catamt, allExp:eachExpData ));
      }
    }
  }
}
