import 'package:flutter/material.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/BalaiKonservasi.dart';
import 'package:mobilecapstone/models/HewanModel.dart';
import 'package:mobilecapstone/models/Kategori.dart';
import 'package:mobilecapstone/pages/DetailBalai.dart';
import 'package:mobilecapstone/theme.dart';

class Cardbalai extends StatelessWidget {
  BalaiKonservasi k;
  Cardbalai({super.key, required this.k});

  @override
  Widget build(BuildContext context) {
    final urlG = k.gambarBalai;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailBalai(balai: k),
        ));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14),
        width: 300,
        height: 200,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(138, 0, 0, 0),
                offset: Offset(0, 4),
                blurRadius: 0.4,
                spreadRadius: 0.0)
          ],
          borderRadius: BorderRadius.circular(20),
          color: putih,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                          "${Config.urlBase}/static/gambarUser/$urlG"),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
            ),
            Container(
              margin: EdgeInsets.all(2),
              padding: EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    k.namaBalai,
                    textAlign: TextAlign.center,
                    style: ijoStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
