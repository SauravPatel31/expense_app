import 'package:expense_app/data/models/category_model.dart';

class AppConstData{

  static List<CategoryModel> mCategory=[
    CategoryModel(catid: 1, catName: "Coffee", catImgPath: "https://cdn-icons-png.flaticon.com/128/3354/3354187.png"),
    CategoryModel(catid: 2, catName: "Fast Food", catImgPath: "https://cdn-icons-png.flaticon.com/128/737/737967.png"),
    CategoryModel(catid: 3, catName: "Restaurants", catImgPath: "https://cdn-icons-png.flaticon.com/128/8503/8503966.png"),
    CategoryModel(catid: 4, catName: "Movie", catImgPath: "https://cdn-icons-png.flaticon.com/128/4221/4221484.png"),
    CategoryModel(catid: 5, catName: "Shopping", catImgPath: "https://cdn-icons-png.flaticon.com/128/2331/2331970.png"),
    CategoryModel(catid: 6, catName: "Travels", catImgPath: "https://cdn-icons-png.flaticon.com/128/2200/2200326.png"),
  ];
 static Set<String> filteredExp={
    'Day', 'Month', 'Year','Category'
 };

  List<Map<String,dynamic>> expenseData =[
    {
      'day':'Tuesday,14',
      'shopingList':{
        "myshoping":{
          'cate':'Shop',
          'shop':'-90',
          'subtitle':'buy new clothes',

        },
        "myE-items":{
          'cate':'Electronics',
          'shop':'-1290',
          'subtitle':'buy new iphone16',
        }
      },
      'total':'-1380'
    },
    {
      'day':'Monday,13',
      'shopingList':{
        "mytrns":{
          'cate':'Transportation',
          'shop':'-90',
          'subtitle':'train ticket',

        },
        "myfood":{
          'cate':'Eat Food',
          'shop':'-150',
          'subtitle':'Eat Food',
        }
      },
      'total':'-240'
    }
  ];
}