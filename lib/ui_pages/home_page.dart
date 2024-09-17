import 'dart:math';
import 'package:expense_app/data/models/filtered_expense_model.dart';
import 'package:expense_app/ui_pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui_pages/bloc/expense_event.dart';
import 'package:expense_app/ui_pages/bloc/expense_state.dart';
import 'package:expense_app/utils/app_const_data.dart';
import 'package:expense_app/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  DateFormat mxFormat=DateFormat.yMMMd();

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

    return Scaffold(
      backgroundColor: backColor(),
      appBar: AppBar(
        backgroundColor: backColor(),
        title:Text("App Name"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 30,))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Profile Details and Select Months..
            Container(
              width:double.infinity,
              height: 80,
              // color: Colors.pinkAccent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ///User Images..
                  InkWell(
                    onTap:(){

                    },
                    child: CircleAvatar(
                      maxRadius: 27,
                      backgroundImage: AssetImage("assets/images/p7.jpeg"),
                      backgroundColor: Colors.cyan,
                    ),
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
                        color: Color(0xffEEF1FC),
                        borderRadius: BorderRadius.circular(8)
                    ),
                    child: DropdownButton(
                      value: selectedMenuItem,
                      icon: Icon(Icons.filter_alt_outlined,size: 26,color: Colors.black,),
                      dropdownColor: Color(0xffEEF1FC),
                      isExpanded: true,
                      underline: Container(),
                      items: AppConstData.filteredExp.map((e){
                        return DropdownMenuItem(child: Text(e),value: e,);}).toList(),onChanged: (value){
                      selectedMenuItem=value!;
                      setState(() {

                      });
                      setState(() {
                        if(value==AppConstData.filteredExp.toList()[0]){
                          mxFormat= DateFormat.yMMMd();
                        }
                        if(value==AppConstData.filteredExp.toList()[1]){
                          mxFormat = DateFormat.yMMM();
                        }
                        if(value==AppConstData.filteredExp.toList()[2]){
                          mxFormat = DateFormat.y();
                        }
                        if(value==AppConstData.mCategory.toString()[3]){
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
               height: 190,
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
                          Text("\$3,734",style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: whiteColor(),

                          ),),
                          Text("than last month",style:  myFonts11(myColor: Colors.white),)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 30,
                      right:-60,
                      child: SizedBox(
                          height: 150,
                          child: Image.asset('assets/images/poster.png',fit: BoxFit.cover,))),
                ],
              ),
            ),
            SizedBox(height: 13,),
            ///Expense List...
            Text("Expense List",style: myFonts18(myFontWeight: FontWeight.w800),),
            SizedBox(height: 13,),
            Expanded(
              child: BlocBuilder<ExpenseBloc,ExpenseState>(builder: (_,state){
                if(state is LoadingState){
                  return Center(child: CircularProgressIndicator());
                }
                if(state is ErrorState){
                  return Center(child: Text(state.errorMsg),);
                }
                if(state is LoadedState){

                  filterExpense(state.mExp);
                  return  Container(
                    width:double.infinity,
                    height: MediaQuery.of(context).size.height/1.2,
                    // color: Colors.deepPurple,
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
                                    Text("\$${allExpenseData[index].totalAmt}",style: myFonts16(myFontWeight: FontWeight.w600),),
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

                                  return InkWell(
                                    onTap: (){
                                      context.read<ExpenseBloc>().add(DeleteExpenseEvent(eid: state.mExp[index].eid!));
                                    },
                                    child: ListTile(
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
                                      trailing: Text("\$${allExpenseData[index].allExp[childindex].eamt}",style: myFonts16(myColor: pinkColor(),myFontWeight: FontWeight.w700)),
                                    ),
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
                  );
                }
                return Container();
              }),
            )

          ],
        ),
      ),
    );
  }
  void filterExpense(mExpense){
    allExpenseData.clear();
    List<String> uqiuesDate = [];
    for(ExpenseModel eachExp in mExpense){
      var eachDate = mxFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.crated_at)));
      if(!uqiuesDate.contains(eachDate)){
        uqiuesDate.add(eachDate);
      }
    }
    print(uqiuesDate);

    for(String eachDate in uqiuesDate){
      num amt=0;
      List<ExpenseModel> eachDateExpense=[];
      for(ExpenseModel eachExp in mExpense){
        var dateFromExp = mxFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.crated_at)));
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

    ///Category Filtered..

      /*for (CategoryModel mCat in AppConstData.mCategory) {
        num amt = 0.0;
        List<ExpenseModel> eachCatId = [];

        for (ExpenseModel eachExp in mExpense) {
          if (eachExp.cat_id == mCat.catid) {
            eachCatId.add(eachExp);
            if (eachExp.etype == "Debit") {
              amt -= eachExp.eamt;
            }
            else {
              amt += eachExp.eamt;
            }
          }
        }
        allExpenseData.add(FilteredExpenseModel(title: mCat.catName, totalAmt: amt, allExp: eachCatId));
      }*/


  }
/*  void filterCategory(List<ExpenseModel> mExpense){
    allExpenseData.clear();


  }*/


}