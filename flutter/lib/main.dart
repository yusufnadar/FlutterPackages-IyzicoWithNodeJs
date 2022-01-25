import 'package:flutter/material.dart';
import 'package:iyzico/payment.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter İyzico',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const PaymentPage(),
    );
  }
}

