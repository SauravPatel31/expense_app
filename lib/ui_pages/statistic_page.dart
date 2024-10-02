import 'dart:math';

import 'package:expense_app/ui_pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui_pages/bloc/expense_state.dart';
import 'package:expense_app/utils/app_styling.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

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
    Colors.red

  ];
  DateFormat mFormat = DateFormat.yMMMd();

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
              items: AppConstData.filteredExp.map((e) {
                return DropdownMenuItem(
                  child: Text(e),
                  value: e,
                );
              }).toList(),
              onChanged: (value) {
                selectedMenuItem = value!;
                setState(() {
                  if (value == AppConstData.filteredExp.toList()[0]) {
                    AppConstData.mFormat = DateFormat.yMMMd();
                    // mFormat =DateFormat.yMMMd();
                  }
                  if (value == AppConstData.filteredExp.toList()[1]) {
                    AppConstData.mFormat = DateFormat.yMMM();
                  }
                  if (value == AppConstData.filteredExp.toList()[2]) {
                    AppConstData.mFormat = DateFormat.y();
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
            children: [
              SizedBox(
                height: 10,
              ),
              ///Expense Title Text and  Week DropdownMenu ..
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Expense Breakdown",
                          style: myFonts18(myFontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Limit \$900 / week",
                          style: myFonts11(
                              myColor: Colors.grey,
                              myFontWeight: FontWeight.w800),
                        )
                      ],
                    ),

                  ],
                ),
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
                          child: Text("No Expense yet!!"),
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
                        Text(
                          "Your expenses are divided into 6 categories",
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
                      for (int i = 0; i < allData.length; i++) {
                        piData.add(PieChartSectionData(
                          value: allData[i].allExp[0].eamt.toDouble(),
                          title: allData[i].title,
                          showTitle:true ,

                          radius:70 ,
                          color:Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
                        ));
                      }

                      return SizedBox(
                        width: 300,
                        height: 300,
                        child: PieChart(
                          PieChartData(
                            sections: piData,
                            sectionsSpace: 2,
                            titleSunbeamLayout: true,
                          )
                        ),
                      );
                    }else{
                      return Text("No Data yet!!");
                    }

                  }
                  return Container();
                },
              )
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
