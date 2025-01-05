import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/Mainpage.dart';
import 'package:mobilecapstone/pages/sp2.dart';
import 'package:mobilecapstone/services/SessionService.dart';
import 'package:mobilecapstone/theme.dart';

class Sp1 extends StatefulWidget {
  const Sp1({super.key});

  @override
  State<Sp1> createState() => _Sp1State();
}

class _Sp1State extends State<Sp1> {
  final ss = SessionService();
  Future<void> cekLogin() async {
    final status = await ss.getToken();

    if (status != null && status.isNotEmpty) {
      UserModel? user = await ss.getUser();
      if (user != null) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Mainpage(usr: user),
        ));
        return;
      }
    }
    Future.delayed(
      Duration(seconds: 3),
      () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Sp2(),
      )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cekLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ijo,
      body: Center(
        child: Text("SIPANDA",
            style: putihStyle.copyWith(
                fontSize: 38, fontWeight: FontWeight.bold, letterSpacing: 10)),
      ),
    );
  }
}
