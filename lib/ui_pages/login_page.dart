import 'package:expense_app/data/local_data/dbhelper.dart';
import 'package:expense_app/ui_pages/bottomnav_page.dart';
import 'package:expense_app/ui_pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget{
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome Back",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter The Email"
              ),
            ),
            SizedBox(height: 10,),
            TextField(
              controller: passController,
              decoration: InputDecoration(
                hintText: "Enter The Password"
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: ()async{
              if(emailController.text.isNotEmpty&&passController.text.isNotEmpty){
                DBhelper myDB = DBhelper.getInstance();
               bool isAuth =await myDB.authUser(emailController.text, passController.text);
               if(isAuth){
                 Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => BottomNavPage(),));
               }
               else{
                 ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content:Text("Invalid Email or Password",style: TextStyle(color: Colors.white),),
                       backgroundColor: Colors.red,
                     )

                 );
               }
              }
              else{
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:Text("Field are required!!",style: TextStyle(color: Colors.white),),
                      backgroundColor: Colors.red,
                    )

                );
              }
            }, child: Text("Login")),
            SizedBox(height: 12,),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
            }, child: Text("New User?Create Account"))
          ],
        ),
      ),
    );
  }

}