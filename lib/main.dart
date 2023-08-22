import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:untitled/global.dart';

import 'home.dart';
import 'lcc_booked_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LccBookedPage(bookedData: jsonEncode(bookedResponse),),//const HomePage(),
    );
  }
}

