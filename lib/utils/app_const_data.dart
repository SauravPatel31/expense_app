import 'package:expense_app/data/models/category_model.dart';
import 'package:intl/intl.dart';

import '../data/models/expense_model.dart';
import '../data/models/filtered_expense_model.dart';

class AppConstData{
  static num amount=0.0;
  static List<CategoryModel> mCategory=[
    CategoryModel(catid: 1, catName: "Coffee", catImgPath: "https://cdn-icons-png.flaticon.com/128/3354/3354187.png"),
    CategoryModel(catid: 2, catName: "Fast Food", catImgPath: "https://cdn-icons-png.flaticon.com/128/737/737967.png"),
    CategoryModel(catid: 3, catName: "Restaurants", catImgPath: "https://cdn-icons-png.flaticon.com/128/8503/8503966.png"),
    CategoryModel(catid: 4, catName: "Movie", catImgPath: "https://cdn-icons-png.flaticon.com/128/4221/4221484.png"),
    CategoryModel(catid: 5, catName: "Shopping", catImgPath: "https://cdn-icons-png.flaticon.com/128/2331/2331970.png"),
    CategoryModel(catid: 6, catName: "Travels", catImgPath: "https://cdn-icons-png.flaticon.com/128/2200/2200326.png"),
  ];
 static Set<String> filteredExp={
    'Day', 'Month', 'Year','Category'
 };

///Date Formte
  static DateFormat mFormat= DateFormat.yMMMd();

 ///Filtered Expense..
  static List<FilteredExpenseModel> filterExpense(List<ExpenseModel> mExpense){
    //allExpenseData.clear();
    List<FilteredExpenseModel> allData=[];
    ///day filtered..
    List<String> uqiuesDate = [];
    // DateFormat mFormat=DateFormat.yMMMd();
    for(ExpenseModel eachExp in mExpense){
      var eachDate = mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(eachExp.crated_at)));
      if(!uqiuesDate.contains(eachDate)){
        uqiuesDate.add(eachDate);
      }
    }
    print(uqiuesDate);
    for(String eachDate in uqiuesDate){
      num amt=0.0;
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
      allData.add(FilteredExpenseModel(title: eachDate, totalAmt: amt, allExp: eachDateExpense));
      //allExpenseData.add(FilteredExpenseModel(title: eachDate, totalAmt: amt, allExp: eachDateExpense));
    }
    return allData;
  }
}