import 'package:expense_app/data/local_data/dbhelper.dart';

class ExpenseModel{
  int? eid;
  int? uid;
  int cat_id;
  String etitle,edesc,etype,crated_at;
  num eamt,ebal;

  ExpenseModel({this.eid, this.uid,required this.etitle,required this.edesc,required this.etype,required this.eamt,required this.ebal,required this.cat_id,required this.crated_at});

  ///Map-->Model
  factory ExpenseModel.fromMap(Map<String,dynamic> map){
    return ExpenseModel(
        eid: map[DBhelper.COLUMN_EXPENSE_ID],
        uid: map[DBhelper.COLUMN_UID],
        etitle: map[DBhelper.COLUMN_EXPENSE_TITLE],
        edesc: map[DBhelper.COLUMN_EXPENSE_DESC],
        etype: map[DBhelper.COLUMN_EXPENSE_TYPE],
        eamt: map[DBhelper.COLUMN_EXPENSE_AMOUNT],
        ebal: map[DBhelper.COLUMN_EXPENSE_BALANCE],
        cat_id: map[DBhelper.COLUMN_EXPENSE_CAT_ID],
        crated_at: map[DBhelper.COLUMN_EXPENSE_CREATED_AT]
    );
  }

  ///model--->Map..
  Map<String,dynamic> toMap(){
    return{
      DBhelper.COLUMN_UID:uid,
      DBhelper.COLUMN_EXPENSE_TITLE:etitle,
      DBhelper.COLUMN_EXPENSE_DESC:edesc,
      DBhelper.COLUMN_EXPENSE_TYPE:etype,
      DBhelper.COLUMN_EXPENSE_AMOUNT:eamt,
      DBhelper.COLUMN_EXPENSE_BALANCE:ebal,
      DBhelper.COLUMN_EXPENSE_CAT_ID:cat_id,
      DBhelper.COLUMN_EXPENSE_CREATED_AT:crated_at
    };
  }

}