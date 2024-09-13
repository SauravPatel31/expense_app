import 'package:expense_app/data/local_data/dbhelper.dart';
import 'package:expense_app/ui_pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/models/user_model.dart';

class RegisterPage extends StatelessWidget{
  TextEditingController emailController =TextEditingController();
  TextEditingController mobController =TextEditingController();
  TextEditingController gendarController =TextEditingController();
  TextEditingController passController =TextEditingController();
  TextEditingController nameController =TextEditingController();
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    body:  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Register Here..",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          ///user name..
          TextField(
            controller: nameController,
            decoration: InputDecoration(
                hintText: "Enter The User Name"
            ),
          ),
          SizedBox(height: 10,),
          ///gander..
          TextField(
            controller: gendarController,
            decoration: InputDecoration(
                hintText: "Enter The Gander"
            ),
          ),
          SizedBox(height: 10,),
          ///email
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                hintText: "Enter The Email"
            ),
          ),
          ///mob Number..
          SizedBox(height: 10,),
          TextField(
            controller: mobController,
            decoration: InputDecoration(
                hintText: "Enter The Mob"
            ),
          ),
          SizedBox(height: 10,),
          ///password..
          TextField(
            controller: passController,
            decoration: InputDecoration(
                hintText: "Enter The Password"
            ),
          ),


          SizedBox(height: 20,),
          ElevatedButton(onPressed: ()async{
            if(nameController.text.isNotEmpty&&gendarController.text.isNotEmpty&&emailController.text.isNotEmpty&&mobController.text.isNotEmpty&&passController.text.isNotEmpty){
              DBhelper myDB = DBhelper.getInstance();
             bool isAdd = await myDB.addNewUser(UserModel(uid: 0, name: nameController.text, email: emailController.text, mobno: mobController.text, gn: gendarController.text, pass: passController.text));
             if(isAdd){
               SharedPreferences pref =await SharedPreferences.getInstance();
               pref.setString("uName", nameController.text.toString());
               Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
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
          }, child: Text("Sign Up")),
          SizedBox(height: 12,),
          TextButton(onPressed: (){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),));
          }, child: Text("you have already account!!"))
        ],
      ),
    ),
   );
  }

}