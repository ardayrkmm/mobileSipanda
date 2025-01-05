import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/HewanModel.dart';
import 'package:mobilecapstone/models/Kategori.dart';
import 'package:mobilecapstone/theme.dart';

class CardKategori extends StatelessWidget {
  KategoriM k;
  CardKategori({super.key, required this.k});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 14),
      width: 115,
      height: 190,
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
                    image: AssetImage("assets/bn.png"), fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
          ),
          Container(
            margin: EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  k.nama_kategori,
                  style: ijoStyle.copyWith(
                      fontSize: 13, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
