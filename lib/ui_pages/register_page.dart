import 'package:expense_app/data/local_data/dbhelper.dart';
import 'package:expense_app/ui_pages/login_page.dart';
import 'package:expense_app/utils/custome_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/user_model.dart';

class RegisterPage extends StatefulWidget{
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController =TextEditingController();

  TextEditingController mobController =TextEditingController();

  TextEditingController gendarController =TextEditingController();

  TextEditingController passController =TextEditingController();

  TextEditingController nameController =TextEditingController();

  String selectedGender='Male';
  bool isDark=false;
  @override
  Widget build(BuildContext context) {
    isDark = Theme.of(context).brightness==Brightness.dark;
   return Scaffold(
    body:  Center(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Register Here..",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              mySizebox(mheight: 20),
              ///user name..
              myTextFields(hinttxt: "Enter the user name",controller: nameController,mIcons: Icon(Icons.edit),),
              mySizebox(),
              ///Select Gender..
              DropdownMenu(dropdownMenuEntries:const [
                DropdownMenuEntry(value: 'Male', label: "Male"),
                DropdownMenuEntry(value: 'Female', label: "Female"),
              ], onSelected: (value){
                selectedGender=value!;
                },
                  trailingIcon: Icon(Icons.accessibility),
                initialSelection: selectedGender,
                width: MediaQuery.of(context).size.width-40,
                  inputDecorationTheme: InputDecorationTheme(
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(width: 1,color: isDark?Colors.white:Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                        borderSide: BorderSide(width: 1,color: isDark?Colors.white:Colors.black)),
                  )
              ),
              mySizebox(),
              ///email
              myTextFields(hinttxt: "Enter the email",controller: emailController,mIcons: Icon(Icons.alternate_email),),
              ///mob Number..
              mySizebox(),
              myTextFields(hinttxt: "Enter the mobil number",controller: mobController,mIcons: Icon(Icons.call),maxlenght: 10,keyBoardType: TextInputType.phone,),
              ///password..
              mySizebox(),
              myTextFields(hinttxt: "Enter the password",controller: passController,maxlenght: 8,mIcons: Icon(Icons.lock),),
              mySizebox(mheight: 20),
              RoundedBatton(btnName: "Sign up", callback: ()async{
                if(nameController.text.isNotEmpty&&emailController.text.isNotEmpty&&mobController.text.isNotEmpty&&passController.text.isNotEmpty){
                  DBhelper myDB = DBhelper.getInstance();
                  bool isAdd = await myDB.addNewUser(UserModel(uid: 0, name: nameController.text, email: emailController.text, mobno: mobController.text, gn: selectedGender, pass: passController.text));
                  if(isAdd){
                    SharedPreferences pref =await SharedPreferences.getInstance();
                    pref.setString("uName", nameController.text.toString());
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                    Navigator.pop(context);
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:Text("Email is Already Exisit!!",style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.red,
                        )

                    );
                  }
                }
                else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:Text("All Text Fields are required!!",style: TextStyle(color: Colors.white),),
                        backgroundColor: Colors.red,
                      )

                  );
                }
              }),
              mySizebox(),
              TextButton(onPressed: (){
                Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),));
              }, child: Text("you have already account!!"))
            ],
          ),
        ),
      ),
    ),
   );
  }
}