import 'package:expense_app/utils/app_styling.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<StatefulWidget>{
  String username="";
  @override
  void initState() {

    super.initState();
    getUserValue();
  }
  getUserValue()async{
    SharedPreferences pref =await SharedPreferences.getInstance();
    username = pref.getString("uName")??"user name";
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor(),
      appBar: AppBar(
        backgroundColor: backColor(),
        title:Text("App Name"),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 30,))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///Profile Details and Select Months..
              Container(
                width:double.infinity,
                height: 80,
                // color: Colors.pinkAccent,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ///User Images..
                    CircleAvatar(
                      maxRadius: 27,
                      backgroundImage: AssetImage("assets/images/p7.jpeg"),
                      backgroundColor: Colors.cyan,
                    ),
                    ///User name day status is like morning  evening..
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        // color: Colors.blue,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Morning",style: myFonts11(myColor: Colors.grey,myFontWeight: FontWeight.bold),),
                            Text(username,style: myFonts16(myFontWeight: FontWeight.w600),),
                          ],
                        ),
                      ),
                    ),
                    ///Month Dropdown menu...
                    DropdownMenu(dropdownMenuEntries:[
                     DropdownMenuEntry(value: 1, label: "Jan"),
                     DropdownMenuEntry(value: 1, label: "Feb"),
                     DropdownMenuEntry(value: 1, label: "Mar"),
                     DropdownMenuEntry(value: 1, label: "Apr"),
                    ],
                    hintText: "Month",

                    )
                  ],
                ),
              ),
              ///Poster(Card)..
              Container(
                width:double.infinity,
                 height: 190,
                decoration: BoxDecoration(
                  color: posterColor(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top:35,
                      child: Container(
                        width: 200,
                        // height: 110,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Expenses total",style: myFonts18(myColor: Colors.white),),
                            ///Expenses total Amount..
                            Text("\$3,734",style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: whiteColor(),

                            ),),
                            Text("than last month",style:  myFonts11(myColor: Colors.white),)
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                        right:-60,
                        child: SizedBox(
                            height: 150,
                            child: Image.asset('assets/images/poster.png',fit: BoxFit.cover,))),
                  ],
                ),
              ),
              SizedBox(height: 13,),
              ///Expense List...
              Text("Expense List",style: myFonts18(myFontWeight: FontWeight.w800),),
              SizedBox(height: 13,),
              Container(
                width:double.infinity,
                height: MediaQuery.of(context).size.height/1.2,
                // color: Colors.deepPurple,
                child: ListView.builder(itemBuilder: (_,index){
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    width: 180,
                    height: 200,
                    // color: Colors.grey,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2)
                    ),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///Day and Total Expense...
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Tuesday,14",style: myFonts16(myFontWeight: FontWeight.w600),),
                                Text("-\$1380",style: myFonts16(myFontWeight: FontWeight.w600),),
                              ],
                            ),
                            Divider(
                              height: 30,
                              thickness: 2,
                            ),
                            ///Your Expenses List and Amounts..
                            Expanded(
                              child: ListView.builder(itemBuilder: (_,index){
                                return ListTile(
                                  leading: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurple.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Icon(Icons.shopping_cart_outlined,color: Colors.deepPurple,),
                                  ),
                                  title: Text("Shop",style: myFonts16(myFontWeight: FontWeight.w500),),
                                  subtitle: Text("buy new clothes",),
                                  trailing: Text("-\$90",style: myFonts16(myColor: pinkColor(),myFontWeight: FontWeight.w700)),
                                );
                              },
                              itemCount: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },itemCount: 5,),
              ),
            ],
          ),
        ),
      ),
    );
  }

}