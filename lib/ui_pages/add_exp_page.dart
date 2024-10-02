import 'dart:ui';
import 'package:expense_app/data/models/expense_model.dart';
import 'package:expense_app/ui_pages/bloc/expense_bloc.dart';
import 'package:expense_app/ui_pages/bloc/expense_event.dart';
import 'package:expense_app/ui_pages/bottom_nav_provider.dart';
import 'package:expense_app/utils/app_const_data.dart';
import 'package:expense_app/utils/app_styling.dart';
import 'package:expense_app/utils/custome_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  List<String> mType = ['Debit', 'Credit'];
  String selectedType = "Debit";
   bool isDark = false;
  @override
  Widget build(BuildContext context) {
    isDark = Theme.of(context).brightness==Brightness.dark;
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Expense"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: MediaQuery.of(context).orientation==Orientation.landscape?Row(
            children: [
              Expanded(child: expenseEntry()),
              mySizebox(),
              Expanded(child: SingleChildScrollView(child: dateTypeExpBtn()))

            ],
          ):SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                expenseEntry(),
                mySizebox(),
                dateTypeExpBtn()

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget expenseEntry(){
    return SingleChildScrollView(
      child: Column(
        children: [
          myTextFields(controller: titleController,
            hinttxt: "Enter your Title",
            mIcons: Icon(Icons.title),

          ),
          mySizebox(),
          myTextFields(
            controller: descController,
            hinttxt: "Enter your Description",
            mIcons: Icon(Icons.description),

          ),
          mySizebox(),
          myTextFields(
            controller: amountController,
            hinttxt: "Enter your Amount",
            mIcons: Icon(Icons.currency_rupee),
            keyBoardType: TextInputType.number,

          ),
          mySizebox(),
          ///select Category..
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                  minimumSize: Size(double.infinity, 55),
                  maximumSize: Size(double.infinity, 55),
                  side: BorderSide(width: 1,color: isDark?Colors.white:Colors.black),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(11))),
              onPressed: () {
                showModalBottomSheet(
                  barrierColor: Colors.black.withOpacity(0.5),
                  backgroundColor: isDark?Color(0xff29282D):null,
                  showDragHandle: true,
                  context: context, builder: (context) {
                  return GridView.builder(
                      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                      itemCount: AppConstData.mCategory.length,
                      itemBuilder: (_, index) {
                        return InkWell(
                          onTap: () {
                            selecteditems = index;
                            Navigator.pop(context);
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Image.network(
                                AppConstData.mCategory[index].catImgPath,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                              Text(AppConstData.mCategory[index].catName,)
                            ],
                          ),
                        );
                      });
                },
                );
              },
              child: selecteditems >= 0 ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    AppConstData.mCategory[selecteditems].catImgPath,
                    width: 35,
                    height: 35,
                  ),
                  Text(
                    ":- ${AppConstData.mCategory[selecteditems].catName}",
                    style: myFonts13(myFontWeight: FontWeight.w600,myColor: isDark?Colors.white:Colors.black),
                  )
                ],
              ): Text("Select Category..",style: myFonts13(myFontWeight: FontWeight.w600,myColor: isDark?Colors.white:Colors.black),)),
        ],
      ),
    );
  }
  Widget dateTypeExpBtn(){
    return Column(
      children: [
        ///select Date...
        StatefulBuilder(
          builder: (context, ss) {
            return OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: isDark?Colors.white:Colors.black, width: 1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11)),
                maximumSize: Size(MediaQuery.of(context).size.width, 55),
                minimumSize: Size(MediaQuery.of(context).size.width, 55),
              ),
              onPressed: () async {
                datePicked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(DateTime.now().year-1, DateTime.now().month,DateTime.now().day),
                    lastDate: DateTime.now());
                ss(() {});
              },
              child: Text(
                "${mFormat.format(datePicked ?? DateTime.now())}",
                style: myFonts13(myFontWeight: FontWeight.w700,myColor: isDark?Colors.white:Colors.black),
              ),
            );
          },
        ),
        mySizebox(),
        ///Dropdown Menu
        StatefulBuilder(builder: (_, ss) {
          return DropdownMenu(
              initialSelection: selectedType,
              width: MediaQuery.of(context).orientation==Orientation.landscape?MediaQuery.of(context).size.width/2.2:MediaQuery.of(context).size.width-30,
              label: Text("Expense Type"),
              inputDecorationTheme: InputDecorationTheme(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide(width: 1,color: isDark?Colors.white:Colors.black)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(11),
                    borderSide: BorderSide(width: 1,color: isDark?Colors.white:Colors.black)),
              ),
              onSelected: (value) {
                selectedType = value!;
                ss(() {});

              },
              dropdownMenuEntries: mType.map((e) {
                return DropdownMenuEntry(value: e, label: e);
              }).toList());
        }),
        mySizebox(mheight: 22),
        ///Add Expense Button..
        RoundedBatton(btnName: "ADD EXPENSE", callback: (){
          if (titleController.text.isNotEmpty && descController.text.isNotEmpty && amountController.text.isNotEmpty && selecteditems > -1)
          {
            if(selectedType=="Debit"){
              AppConstData.amount-=num.parse(amountController.text);

            }else{
              AppConstData.amount+=num.parse(amountController.text);
            }
            context.read<ExpenseBloc>().add(AddExpenseEvent(
                addExpense: ExpenseModel(
                    etitle: titleController.text,
                    edesc: descController.text,
                    etype: selectedType,
                    eamt: num.parse(amountController.text),
                    ebal: AppConstData.amount,
                    cat_id: AppConstData.mCategory[selecteditems].catid,
                    crated_at: (datePicked??DateTime.now()).millisecondsSinceEpoch.toString())));
            context.read<BottomNavProvider>().updateBottomPage(0);

          }else {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "All field are required",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
        })
      ],
    );
  }
}

