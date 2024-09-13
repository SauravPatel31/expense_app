import 'package:expense_app/ui_pages/bloc/expense_event.dart';
import 'package:expense_app/ui_pages/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/local_data/dbhelper.dart';

class ExpenseBloc extends Bloc<ExpenseEvent,ExpenseState>{
  DBhelper dBhelper;
  ExpenseBloc({required this.dBhelper}):super(InitialsState()){
    ///add expense..
    on<AddExpenseEvent>((event,emit)async{
      emit(LoadingState());
     bool isAdd =await dBhelper.insertExpense(event.addExpense);
     if(isAdd){
       var mExp =await dBhelper.fetchExpense();
       emit(LoadedState(mExp: mExp));
     }
     else{
       emit(ErrorState(errorMsg: "Expense is No Add !!"));
     }
    });
    ///update expense..
    on<UpdateExpenseEvent>((event,emit)async{
      emit(LoadingState());
     bool isUpdate =await dBhelper.updateExpense(event.updateExpense, event.eid);
     if(isUpdate){
       var mExp =await dBhelper.fetchExpense();
       emit(LoadedState(mExp: mExp));
     }
     else{
       emit(ErrorState(errorMsg: "Expense is Not Update!!"));
     }
    });
    ///delete expense..
    on<DeleteExpenseEvent>((event,emit)async{
      emit(LoadingState());
      bool isDelete = await dBhelper.deleteExpense(event.eid);
      if(isDelete){
        var mExp = await dBhelper.fetchExpense();
        emit(LoadedState(mExp: mExp));
      }
      else{
        emit(ErrorState(errorMsg: "Expense is not Delete!!!"));
      }
    });
    ///Get All Expense...
    on<getAllExpense>((event,emit)async{
      emit(LoadingState());
      var mExp =await dBhelper.fetchExpense();
      emit(LoadedState(mExp: mExp));
    });
  }

}