import 'package:first_app/Screens/add_product.dart';
import 'package:flutter/material.dart';
import 'package:first_app/Screens/welcome_page.dart';
import 'package:first_app/constants/appcolors.dart';
//import 'package:first_app/buttons/list_item.dart';
import 'package:first_app/buttons/bar_buttons.dart';
import 'package:first_app/buttons/general_button.dart';
import 'package:first_app/dialogs/general_dialog.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Smart Cupboards',
        //home: WelcomeScreen(),
        // home: Scaffold(
        //     body: Center(
        //         child: Product(
        //             maintitle: "foof",
        //             color: AppColors.PINK,
        //             createPage: () => add_product(),
        //             image: 'images/Button.png',
        //             edges:'round')))
        home: Scaffold(
            body: Center(
                child: GenDisplay(
          maintitle:
              "You added to your cart a\n product you already seem to \n have in your Cupboards! \n Are you sure you want to\n proceed with buying it?",
          color: AppColors.PURPLE,
          left: "No, go back",
          right: "Yes, I'm sure",
          edges: 5,
          createPageL: () => add_product(),
          createPageR: () => add_product(),
        ))));
  }
}

// class Product extends StatefulWidget {
//   const Product({Key? key}) : super(key: key);

//   @override
//   State<Product> createState() => _ProductState();
// }

// class _ProductState extends State<Product> {
//   bool _LongPressed = false;
//   bool _toDelete = false;
  
//   @override
//   Widget build(BuildContext context){

//   return GestureDetector(
//           onLongPress: (){
//             setState(() {
//               _LongPressed = true;
//             });
//           },
//           child:  Container(
//             padding: const EdgeInsets.all(0),
//             color: _LongPressed? AppColors.BLUE: AppColors.GREY,
//             child: ListTile(
//                title:const Text('Product Name'),
//                subtitle:const Text('Product Brand'),
//                trailing: _LongPressed? Checkbox(value:false) : null,
//             ),
          
//           )
//         ); //Gesture Detector
//   } //Widget
// } //_ProductState class
