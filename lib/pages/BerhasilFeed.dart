import 'package:flutter/material.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';

class BerhasilFeed extends StatelessWidget {
  const BerhasilFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Text(
                "KOMENTAR BERHASIL!",
                style: TextStyle(
                  color: Color(0xff014224),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Image.asset(
                    "assets/gambarS.png",
                    width: double.infinity,
                    height: 300,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Terima kasih telah melakukan komentar.",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  btnBaru(
                    w: double.infinity,
                    h: 44,
                    nama: "Selesaii",
                    fn: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
