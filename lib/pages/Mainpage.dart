import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/HalamanScan.dart';
import 'package:mobilecapstone/pages/Sentiment.dart';
import 'package:mobilecapstone/pages/chatbot.dart';
import 'package:mobilecapstone/pages/home.dart';
import 'package:mobilecapstone/pages/profil.dart';
import 'package:mobilecapstone/theme.dart';

class Mainpage extends StatefulWidget {
  final UserModel usr;
  Mainpage({super.key, required this.usr});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  int index = 0;

  void pilihNav(int pilih) {
    setState(() {
      index = pilih;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> halaman = [
      Home(
        usr: widget.usr,
      ),
      const HalamanScan(),
      Profil(key: Key("halamanProfil"), usr: widget.usr),
      SentimentHalaman()
    ];
    Widget fl() {
      if (index != 0) {
        return SizedBox.shrink();
      } else {
        return FloatingActionButton(
            backgroundColor: ijo,
            child: Image.asset(
              'assets/chatbot.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ChatBot(),
              ));
            });
      }
    }

    return Scaffold(
      body: halaman[index],
      floatingActionButton: fl(),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
        color: Colors.transparent,
        child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(17),
            height: 70,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18), color: ijo),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => pilihNav(0),
                  child: Container(
                    width: 24,
                    height: 27,
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    child: Image.asset(
                      "assets/home.png",
                      color: index == 0 ? putih : putih.withOpacity(0.2),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => pilihNav(1),
                  child: Container(
                    width: 24,
                    height: 27,
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    child: Image.asset(
                      "assets/scan.png",
                      color: index == 1 ? putih : putih.withOpacity(0.2),
                    ),
                  ),
                ),
                GestureDetector(
                  key: Key("tombolProfil"),
                  onTap: () => pilihNav(2),
                  child: Container(
                    width: 24,
                    height: 27,
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    child: Image.asset(
                      "assets/Customer.png",
                      color: index == 2 ? putih : putih.withOpacity(0.2),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => pilihNav(3),
                  child: Container(
                    width: 24,
                    height: 27,
                    margin: EdgeInsets.symmetric(horizontal: 18),
                    child: Icon(
                      Icons.comment,
                      color: index == 3 ? putih : putih.withOpacity(0.2),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
