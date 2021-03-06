import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whitepeach/model/category_model.dart';
import 'package:whitepeach/model/product_model.dart';
import 'package:whitepeach/model/user_model.dart';
import 'package:whitepeach/screens/home_screen.dart';

import 'file:///D:/Project/Flutter/whitepeach/lib/config/constants.dart';
import 'package:whitepeach/screens/welcome_screen.dart';

void main() => runApp(
      MultiProvider(
        providers: [
          Provider<CategoryState>(create: (_) => CategoryState()),
          Provider<ProductState>(create: (_) => ProductState()),
          Provider<UserState>(create: (_) => UserState()),
        ],
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meditation App',
      theme: ThemeData(
        fontFamily: "Cairo",
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: WelcomeScreen(),
    );
  }
}
