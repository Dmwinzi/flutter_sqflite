import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_todo/Screens/Home.dart';

void main(){
    runApp(MyApp());
}



class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle(statusBarColor: Colors.transparent)
      );
    return MaterialApp(
       themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: "Memoix",
        home: Home(),
    );
  }


}

