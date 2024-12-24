import 'package:flutter/material.dart';
import 'package:slider/presentation/SymptomsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SymptomsPage(),
      routes: {
        // تأكد من أن المسار صحيح
      },

      // إزالة شريط DEBUG
    );
  }
}
