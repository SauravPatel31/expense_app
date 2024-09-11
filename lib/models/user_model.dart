import '../data/local_data/dbhelper.dart';

class UserModel{
  int uid;
  String name,email,mobno,gn,pass;
  UserModel({required this.uid,required this.name,required this.email,required this.mobno,required this.gn,required this.pass});

  ///Map-->Model
  factory UserModel.fromMap(Map<String,dynamic> map){
    return UserModel(
        uid: map[DBhelper.COLUMN_UID],
        name: map[DBhelper.COLUMN_UNAME],
        email:map[DBhelper.COLUMN_UEMAIL],
        mobno: map[DBhelper.COLUMN_UMOBNO],
        gn: map[DBhelper.COLUMN_UGENDER],
        pass: map[DBhelper.COLUMN_UPASS]);
  }

  Map<String,dynamic> toMap(){
    return {
      DBhelper.COLUMN_UNAME:name,
      DBhelper.COLUMN_UEMAIL:email,
      DBhelper.COLUMN_UMOBNO:mobno,
      DBhelper.COLUMN_UGENDER:gn,
      DBhelper.COLUMN_UPASS:pass
    };
  }
}