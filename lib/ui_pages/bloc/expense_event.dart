import 'package:expense_app/data/models/expense_model.dart';

abstract class ExpenseEvent {}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel addExpense;
  AddExpenseEvent({required this.addExpense});
}
class UpdateExpenseEvent extends ExpenseEvent{
  ExpenseModel updateExpense;
  int eid;
  UpdateExpenseEvent({required this.updateExpense,required this.eid});
}

class DeleteExpenseEvent extends ExpenseEvent{
  int eid;
  DeleteExpenseEvent({required this.eid});
}
class getAllExpense extends ExpenseEvent{

}