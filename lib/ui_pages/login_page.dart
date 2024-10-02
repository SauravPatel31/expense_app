import 'package:expense_app/data/local_data/dbhelper.dart';
import 'package:expense_app/ui_pages/bottomnav_page.dart';
import 'package:expense_app/ui_pages/register_page.dart';
import 'package:expense_app/utils/custome_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget{
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
            myTextFields(hinttxt: "Enter the mail",controller: emailController,),
            SizedBox(height: 10,),
            myTextFields(hinttxt: "Enter the password",controller: passController,),
            SizedBox(height: 20,),
            RoundedBatton(btnName: "Login", callback:()async{
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
            }),
            SizedBox(height: 12,),
            TextButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage(),));
            }, child: Text("New User?Create Account",))
          ],
        ),
      ),
    );
  }
}