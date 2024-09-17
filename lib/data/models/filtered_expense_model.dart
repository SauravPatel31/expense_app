import 'expense_model.dart';

class FilteredExpenseModel{
  String title;
  num totalAmt;
  List<ExpenseModel> allExp;
  FilteredExpenseModel({required this.title,required this.totalAmt,required this.allExp});
}