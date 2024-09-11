import 'dart:io';

import 'package:expense_app/models/expense_model.dart';
import 'package:expense_app/models/user_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBhelper{
  ///singleton Instance..
  DBhelper._();

  static DBhelper getInstance()=>DBhelper._();

  ///User id KEY
  static final String UID_KEY="uid";

  ///Expense table name..
  static final String TABLE_EXPENSE="expense";
  static final String TABLE_USER="user";
 ///Expense Column name..
  static final String COLUMN_EXPENSE_ID="e_id";
  static final String COLUMN_EXPENSE_TITLE="e_title";
  static final String COLUMN_EXPENSE_DESC="e_desc";
  static final String COLUMN_EXPENSE_AMOUNT="e_amount";
  static final String COLUMN_EXPENSE_BALANCE="e_balance";
  static final String COLUMN_EXPENSE_TYPE="e_type";
  static final String COLUMN_EXPENSE_CAT_ID="e_cat_id";
  static final String COLUMN_EXPENSE_CREATED_AT="e_create_at";

  ///User Column name..
  static final String COLUMN_UID="u_id";
  static final String COLUMN_UNAME="u_name";
  static final String COLUMN_UEMAIL="u_email";
  static final String COLUMN_UMOBNO="u_mob_no";
  static final String COLUMN_UGENDER="u_gender";
  static final String COLUMN_UPASS="u_pass";

  Database? mdb;

  ///getDB and openDB..
  Future<Database> getDB()async{
    mdb??=await openDB();
    return mdb!;
  }

  Future<Database> openDB()async{
    Directory appDirc =await getApplicationDocumentsDirectory();
    String dbPath = join(appDirc.path,"expensoDB.db");
    return await openDatabase(dbPath,version: 1,onCreate: (db,version){
      db.execute("create table $TABLE_EXPENSE ($COLUMN_EXPENSE_ID integer primary key autoincrement,$COLUMN_UID integer,$COLUMN_EXPENSE_TITLE text,$COLUMN_EXPENSE_DESC text,$COLUMN_EXPENSE_TYPE text,$COLUMN_EXPENSE_AMOUNT real,$COLUMN_EXPENSE_BALANCE real,$COLUMN_EXPENSE_CAT_ID integer,$COLUMN_EXPENSE_CREATED_AT text)");
      db.execute("create table $TABLE_USER ($COLUMN_UID integer primary key autoincrement,$COLUMN_UNAME text,$COLUMN_UEMAIL text unique,$COLUMN_UMOBNO text,$COLUMN_UGENDER text,$COLUMN_UPASS text)");
    });
  }

  ///expense quires..
  Future<bool> insertExpense(ExpenseModel addExpense)async{
    var mDB =await getDB();
    var uid =await getUUID();
    addExpense.uid=uid;
    int rowEffected = await mDB.insert(TABLE_EXPENSE, addExpense.toMap());
    return rowEffected>0;
  }
  Future<List<ExpenseModel>> fetchExpense()async{
    var mDB =await getDB();
    var uid = await getUUID();

   var mDate = await mDB.query(TABLE_EXPENSE,where: "$COLUMN_UID=?",whereArgs: ['$uid']);
   List<ExpenseModel> mExpense =[];
   for(Map<String,dynamic> eachdate in mDate){
     mExpense.add(ExpenseModel.fromMap(eachdate));
   }
   return mExpense;
  }

  ///SignUp User Quires..
  Future<bool> addNewUser(UserModel newuser)async{
    var mDB =await getDB();

    bool haveAccount =await checkEmailisAlreadyExistis(newuser.email);
    bool accCreated=false;
    if(!haveAccount){
      int rowEffected =await mDB.insert(TABLE_USER, newuser.toMap());
      accCreated= rowEffected>0;
    }
    return accCreated;

  }
  ///check email is already existis or note..
  Future<bool> checkEmailisAlreadyExistis(String email)async{
    var mDB =await getDB();
   var mdata =await mDB.query(TABLE_USER,where: "$COLUMN_UEMAIL=?",whereArgs: [email]);
   return mdata.isNotEmpty;
  }

  ///Auth Login User..

  Future<bool> authUser(String email,String pass)async{
    var mDB =await getDB();

   var mData =await mDB.query(TABLE_USER,where: "$COLUMN_UEMAIL=? AND $COLUMN_UPASS=?",whereArgs: [email,pass]);
   if(mData.isNotEmpty){
     setUUID(UserModel.fromMap(mData[0]).uid);
   }
   return mData.isNotEmpty;
  }

  Future<int> getUUID()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    return pref.getInt(UID_KEY)!;
  }
  void setUUID(int uid)async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    pref.setInt(UID_KEY, uid);
  }
}