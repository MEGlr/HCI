import 'package:flutter/material.dart';
import 'package:first_app/buttons/general_button.dart';
import 'package:first_app/constants/appcolors.dart';
import 'package:first_app/Screens/my_cup_list.dart';
import 'package:first_app/add_form.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('SMART\n CUPBOARDS',
                textAlign: TextAlign.center,
                style: TextStyle(fontFamily: "Rationale")),
            centerTitle: true,
            backgroundColor: AppColors.BLUE),
        body: Container(
            color: AppColors.VERY_LIGHT_BLUE,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Container(
                    alignment: Alignment.center,
                    color: AppColors.VERY_LIGHT_BLUE,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GenButton(
                            maintitle: 'My Cupboards',
                            color: AppColors.PINK,
                            edges: 0,
                            createPage: () => my_cup_list()),
                        SizedBox(height: 20),
                        GenButton(
                            maintitle: 'My Favourite\n Products',
                            color: AppColors.BLUE,
                            edges: 0,
                            createPage: () => my_cup_list()),
                        SizedBox(height: 20),
                        GenButton(
                            maintitle: 'My Grocery Lists',
                            color: AppColors.LIGHT_BLUE,
                            edges: 0,
                            createPage: () => my_cup_list()),
                      ],
                    ),
                  ),
                  const Flexible(fit: FlexFit.tight, child: SizedBox()),
                  Container(
                    //   child: Padding(
                    // padding: const EdgeInsets.all(0.0),
                    child: Image.asset('images/Button.png',
                        height: 60, alignment: Alignment.bottomRight),
                  ),
                ])));
  }
}
