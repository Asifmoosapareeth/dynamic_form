import 'package:dynamic_form/view/bottom_nav.dart';
import 'package:flutter/material.dart';

import 'view/form_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: BottomNavScreen()
    );
  }
}

