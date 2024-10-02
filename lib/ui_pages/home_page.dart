import 'dart:math';
import 'package:expense_app/data/local_data/dbhelper.dart';
import 'package:expense_app/data/models/filtered_expense_model.dart';
import 'package:expense_app/ui_pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui_pages/bloc/expense_event.dart';
import 'package:expense_app/ui_pages/bloc/expense_state.dart';
import 'package:expense_app/ui_pages/login_page.dart';
import 'package:expense_app/utils/app_const_data.dart';
import 'package:expense_app/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/category_model.dart';
import '../data/models/expense_model.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<StatefulWidget>{
  List<FilteredExpenseModel> allExpenseData=[];
  String username="";
  String selectedMenuItem="Day";
  // DateFormat mFormat= DateFormat.yMMMd();
  bool isDark=false;
  MediaQueryData ? mqData;

   List<ExpenseModel> mExpense=[];
  @override
  void initState() {
    super.initState();
    getUserValue();
    context.read<ExpenseBloc>().add(getAllExpense());
  }
  getUserValue()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    username = pref.getString("uName")??"user name";
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    mqData = MediaQuery.of(context);
    isDark = Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:Text("App Name"),
        actions: [
          PopupMenuButton(itemBuilder: (context){
            return [
              PopupMenuItem(child: Row(children: [
                Icon(Icons.logout_outlined),
                Text("Logout")
              ],),padding: EdgeInsets.all(10),onTap: ()async{
                SharedPreferences pref =await SharedPreferences.getInstance();
                pref.setInt(DBhelper.UID_KEY, -1);
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
              },)
            ];
          },
            color: isDark?Color(0xff29282D):null,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: EdgeInsets.all(15),
          position: PopupMenuPosition.under,
          )

        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: MediaQuery.of(context).orientation==Orientation.landscape?Row(
          children: [
            Expanded(child: userInfo()),
            SizedBox(width: 20,),
            Expanded(child: expenseDetails()),
          ],
        ):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            userInfo(),
            Expanded(child: expenseDetails()),
          ],
        ),
      ),
    );
  }
  Widget userInfo(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///User Name AND Dropdown Menu..
        Container(
            width:double.infinity,
            height: 80,
            // color: Colors.pinkAccent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ///User Images..
                CircleAvatar(
                  maxRadius: 27,
                  backgroundImage: AssetImage("assets/images/p7.jpeg"),
                ),
                ///User name day status is like morning  evening..
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    // color: Colors.blue,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Morning",style: myFonts11(myColor: Colors.grey,myFontWeight: FontWeight.bold),),
                        Text(username,style: myFonts16(myFontWeight: FontWeight.w600),),
                      ],
                    ),
                  ),
                ),
                ///Filtered Dropdown menu...
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  margin: EdgeInsets.all(5),
                  width: 150,
                  decoration: BoxDecoration(
                    //color: Color(0xffEEF1FC),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 1,color: isDark?Colors.white:Colors.black)
                  ),
                  child: DropdownButton(
                    value: selectedMenuItem,
                    icon: Icon(Icons.filter_alt_outlined,size: 26,),
                    //dropdownColor: Color(0xffEEF1FC),
                    isExpanded: true,
                    underline: Container(),
                    items: AppConstData.filteredExp.map((e){
                      return DropdownMenuItem(child: Text(e),value: e,);}).toList(),onChanged: (value){
                    selectedMenuItem=value!;
                      setState(() {
                        if(value==AppConstData.filteredExp.toList()[0]){
                          AppConstData.mFormat=DateFormat.yMMMd();
                         // mFormat =DateFormat.yMMMd();
                        }
                        if(value==AppConstData.filteredExp.toList()[1]){
                          AppConstData.mFormat =DateFormat.yMMM();
                        }
                        if(value==AppConstData.filteredExp.toList()[2]){
                          AppConstData.mFormat =DateFormat.y();
                        }
                      });
                  },),
                )
              ],
            ),
          ),
        ///Poster(Card)..
        Container(
          width:double.infinity,
          height: MediaQuery.of(context).orientation==Orientation.landscape?MediaQuery.of(context).size.height/2.5:MediaQuery.of(context).size.height/4.6,
          decoration: BoxDecoration(
            color: posterColor(),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              Positioned(
                top:35,
                child: Container(
                  width: 200,
                  // height: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Expenses total",style: myFonts18(myColor: Colors.white),),
                      ///Expenses total Amount..
                      BlocBuilder<ExpenseBloc,ExpenseState>(
                        builder: (_,state){
                          if(state is LoadedState){
                            if(state.mExp.isNotEmpty){
                              AppConstData.amount = state.mExp.last.ebal;
                              return FittedBox(
                                child: Text("₹${state.mExp.last.ebal}",style: TextStyle(
                                   fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),),
                              );
                            }else{
                              return Text("₹0.0",style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ));
                            }
                          }

                          return Container();
                        },

                      ),
                      Text("than last month",style:  myFonts11(myColor: Colors.white),)
                    ],
                  ),
                ),
              ),
              Positioned(
                  top: 30,
                  right:-60,
                  child: SizedBox(
                      height: mqData!.orientation==Orientation.landscape?mqData!.size.height/3.3:mqData!.size.height/5.6,
                      child: Image.asset('assets/images/poster.png',fit: BoxFit.cover,))),
            ],
          ),
        ),
      ],
    );
  }
  Widget expenseDetails(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ///Expense List...
        Text("Expense List",style: myFonts18(myFontWeight: FontWeight.w800),),
        Expanded(
          child: BlocBuilder<ExpenseBloc,ExpenseState>(builder: (_,state){
            if(state is LoadingState){
              return Center(child: CircularProgressIndicator());
            }
            if(state is ErrorState){
              return Center(child: Text(state.errorMsg),);
            }
            if(state is LoadedState){
              allExpenseData=AppConstData.filterExpense(state.mExp);
              if(state.mExp.isNotEmpty){
                AppConstData.filterExpense(state.mExp);
                //filterExpense(state.mExp);
                if(selectedMenuItem=="Category"){
                  filteredExpCat(state.mExp);}
                AppConstData.amount = state.mExp.last.ebal;
                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        //reverse: selectedMenuItem==AppConstData.filteredExp.toList()[0]?true:false,
                        itemBuilder: (_,index){

                          return Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            // color: Colors.grey,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(width: 1,color: Colors.grey)
                            ),
                            child: Center(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ///Day and Total Expense...
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(allExpenseData[index].title,style: myFonts16(myFontWeight: FontWeight.w600),),
                                        Text("₹${allExpenseData[index].totalAmt}",style: myFonts16(myFontWeight: FontWeight.w600,myColor: allExpenseData[index].totalAmt>=0?Colors.green:pinkColor()),),
                                      ],
                                    ),
                                    Divider(
                                      height: 30,
                                      thickness: 2,
                                    ),
                                    ///Your Expenses List and Amounts..
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics( ),
                                      itemBuilder: (_,childindex){
                                        return ListTile(
                                          leading: Container(
                                            width: 50,
                                            height: 50,
                                            padding: EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                                color:Colors.primaries[Random().nextInt(Colors.primaries.length-1)],
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            child: Image.network(AppConstData.mCategory.where((element)=>element.catid==allExpenseData[index].allExp[childindex].cat_id).toList()[0].catImgPath),
                                          ),
                                          title: Text(allExpenseData[index].allExp[childindex].etitle,style: myFonts16(myFontWeight: FontWeight.w500),),
                                          subtitle: Text(allExpenseData[index].allExp[childindex].edesc),
                                          trailing: Text("₹${allExpenseData[index].allExp[childindex].etype=="Debit" ? "-${allExpenseData[index].allExp[childindex].eamt}":"+${allExpenseData[index].allExp[childindex].eamt}"  }",style: myFonts16(myColor:allExpenseData[index].allExp[childindex].etype=="Debit"? pinkColor():Colors.green,myFontWeight: FontWeight.w700)),
                                        );
                                      },
                                      itemCount: allExpenseData[index].allExp.length,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },itemCount: allExpenseData.length,),
                    ),
                  ],
                );
              }
              else{
                return Center(child: Text("No Expenes yet!!"),);
              }

            }
            return Container();
          }),
        )
      ],
    );
  }
  
  ///Filtered Expense Date Wise..
  /*void filterExpense(mExpense){
    allExpenseData.clear();
    ///day filtered..
    List<String> uqiuesDate = [];
    for(ExpenseModel eachExp in mExpense){
      var eachDate = mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.crated_at)));
      if(!uqiuesDate.contains(eachDate)){
        uqiuesDate.add(eachDate);
      }
    }
    print(uqiuesDate);
    for(String eachDate in uqiuesDate){
      num amt=0;
      List<ExpenseModel> eachDateExpense=[];
      for(ExpenseModel eachExp in mExpense){
        var dateFromExp = mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.crated_at)));
        if(eachDate==dateFromExp){
          eachDateExpense.add(eachExp);
          if(eachExp.etype=="Debit"){
            amt-=eachExp.eamt;
          }
          else{
            amt+=eachExp.eamt;
          }
        }
      }
      allExpenseData.add(FilteredExpenseModel(title: eachDate, totalAmt: amt, allExp: eachDateExpense));
    }

  }*/
  ///Filtered Expense Data CategoryWise
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

///Filtered Expense Data Date wise..
/*void filterExpense(mExpense){
  allExpenseData.clear();
  ///day filtered..
  List<String> uqiuesDate = [];
  for(ExpenseModel eachExp in mExpense){
    var eachDate = mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.crated_at)));
    if(!uqiuesDate.contains(eachDate)){
      uqiuesDate.add(eachDate);
    }
  }
  print(uqiuesDate);
  for(String eachDate in uqiuesDate){
    num amt=0;
    List<ExpenseModel> eachDateExpense=[];
    for(ExpenseModel eachExp in mExpense){
      var dateFromExp = mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.crated_at)));
      if(eachDate==dateFromExp){
        eachDateExpense.add(eachExp);
        if(eachExp.etype=="Debit"){
          amt-=eachExp.eamt;
        }
        else{
          amt+=eachExp.eamt;
        }
      }
    }
    allExpenseData.add(FilteredExpenseModel(title: eachDate, totalAmt: amt, allExp: eachDateExpense));
  }

}*/
