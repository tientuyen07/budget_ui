import 'package:budget_ui/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Budget UI",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[50],
          primarySwatch: Colors.green,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(primary: Colors.green)),
      home: const HomeScreen(),
    );
  }
}
