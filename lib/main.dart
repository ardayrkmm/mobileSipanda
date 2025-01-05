import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/HalamanLapor.dart';
import 'package:mobilecapstone/pages/HalamanScan.dart';
import 'package:mobilecapstone/pages/Mainpage.dart';
import 'package:mobilecapstone/pages/Scanpage.dart';
import 'package:mobilecapstone/pages/chatbot.dart';
import 'package:mobilecapstone/pages/detailpage.dart';
import 'package:mobilecapstone/pages/home.dart';
import 'package:mobilecapstone/pages/login.dart';
import 'package:mobilecapstone/pages/profil.dart';
import 'package:mobilecapstone/pages/register.dart';
import 'package:mobilecapstone/pages/sp1.dart';
import 'package:mobilecapstone/pages/sp2.dart';
import 'package:mobilecapstone/providers/LaporanP.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mobilecapstone/providers/chatbot.dart';
import 'package:mobilecapstone/providers/scanProvider.dart';
import 'package:mobilecapstone/providers/sentimeProvider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => authP(),
    ),
    ChangeNotifierProvider(
      create: (context) => chatbotProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => scanProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => Laporanp(),
    ),
    ChangeNotifierProvider(
      create: (context) => SentimenProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Sp1(),
    );
  }
}
