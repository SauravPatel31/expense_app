import 'package:expense_app/utils/app_const_data.dart';
import 'package:expense_app/utils/app_styling.dart';
import 'package:expense_app/utils/custome_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddExpPage extends StatefulWidget {
  @override
  State<AddExpPage> createState() => _AddExpPageState();
}

class _AddExpPageState extends State<AddExpPage> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descController = TextEditingController();

  TextEditingController amountController = TextEditingController();

  int selecteditems = -1;
  DateTime? datePicked;
  DateFormat mFormat = DateFormat.yMMMd();

  List<String> mType=['Debit','Credit'];
  String selectedType="Debit";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Expense"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            myTextFields(
                controller: titleController, hinttxt: "Enter your Title"),
            mySizebox(),
            myTextFields(
                controller: descController, hinttxt: "Enter your Description",),
            mySizebox(),
            myTextFields(
                controller: amountController, hinttxt: "Enter your Amount",keyBoardType: TextInputType.number,),
            mySizebox(),
            ///select Category..
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  maximumSize: Size(double.infinity, 55),
                    side: BorderSide(width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11))
                ),
                onPressed: () {
              showModalBottomSheet(context: context, builder: (context) {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemCount: AppConstData.mCategory.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          selecteditems = index;
                          setState(() {});
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              Image.network(
                                AppConstData.mCategory[index].catImgPath,
                                width: 50, height: 50, fit: BoxFit.cover,),
                              Text(AppConstData.mCategory[index].catName)
                            ],
                          ),
                        ),
                      );
                    }
                );
              },);
            }, child: selecteditems >= 0 ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  AppConstData.mCategory[selecteditems].catImgPath, width: 35,
                  height: 35,),
                Text(":- ${AppConstData.mCategory[selecteditems].catName}",style: myFonts13(myFontWeight: FontWeight.w600),)
              ],) : Text("Select Category..",style: myFonts13(myFontWeight: FontWeight.w600),)),
            mySizebox(),
            ///select Date...
            StatefulBuilder(builder: (context, ss) {
              return OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.black,width: 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                  maximumSize: Size(MediaQuery.of(context).size.width, 55),
                  minimumSize: Size(MediaQuery.of(context).size.width, 55),
                ),
                onPressed: () async {
                  datePicked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(DateTime.now().year,DateTime.now().month-1),
                      lastDate: DateTime.now()
                  );
                  ss(() {});
                }, child:Text("${mFormat.format(datePicked??DateTime.now())}",style: myFonts13(myFontWeight: FontWeight.w700),),
              );
            },),

            mySizebox(),
            ///Dropdown Menu
            StatefulBuilder(builder: (_,ss){
              return  DropdownMenu(
                  initialSelection: selectedType,
                  width: MediaQuery.of(context).size.width-30,
                  label: Text("Expense Type"),
                  inputDecorationTheme: InputDecorationTheme(
                    focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(11),borderSide: BorderSide(width: 1)) ,
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(11),borderSide: BorderSide(width: 1)),

                  ),
                  onSelected: (value){
                    selectedType=value!;
                    ss(() {
                      print("ss called!!");
                    });
                    print(selectedType);
                  },
                  dropdownMenuEntries: mType.map((e){
                    return DropdownMenuEntry(value: e, label: e);

                  }).toList());
            }),
            mySizebox(mheight: 22),
            ///Add Expense Button..
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: pinkColor(),
                  minimumSize: Size(MediaQuery.of(context).size.width, 55),
                  maximumSize: Size(MediaQuery.of(context).size.width, 55),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
                  elevation: 5,
                  shadowColor: pinkColor(),

                ),
                onPressed: (){
                  if(titleController.text.isNotEmpty&&descController.text.isNotEmpty&&amountController.text.isNotEmpty&&selecteditems>-1){

                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text("All field are required",style: TextStyle(color: Colors.white),),
                          backgroundColor: Colors.red,

                        ));
                  }
                }, child: Text("ADD EXPENSE",style: myFonts16(myColor: whiteColor()),))

          ],
        ),
      ),
    );
  }
}