import 'package:flutter/material.dart';
import 'package:newsaty/View/Pages/HomePage.dart';
import 'package:newsaty/View/Pages/LoginPage.dart';
import 'package:newsaty/ViewModel/AuthProvider.dart';
import 'package:newsaty/ViewModel/NewsProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => NewsProvider()),
      ],
      child: MaterialApp(
        title: 'Newsaty',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      ),
    );
  }
}
