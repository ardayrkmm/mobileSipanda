import 'package:flutter/material.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/theme.dart';

class DetailProfil extends StatelessWidget {
  UserModel usr;
  DetailProfil({super.key, required this.usr});

  @override
  Widget build(BuildContext context) {
    Widget bagianHeader() {
      return Center(
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10000),
              image: DecorationImage(
                  image: NetworkImage(
                    "${Config.urlBase}/static/gambarUser/${usr.imgProfil!}",
                  ),
                  fit: BoxFit.cover)),
        ),
      );
    }

    Widget bagianContent() {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      image:
                          DecorationImage(image: AssetImage("assets/nm.png"))),
                ),
                SizedBox(
                  width: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama",
                      style: itemStyle.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      usr.nama,
                      style: itemStyle.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  child: Icon(
                    Icons.email,
                    color: ijo,
                    size: 40,
                  ),
                ),
                SizedBox(
                  width: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: itemStyle.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      usr.email,
                      style: itemStyle.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/telp.png"))),
                ),
                SizedBox(
                  width: 18,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Telepon",
                      style: itemStyle.copyWith(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      usr.noTelp,
                      style: itemStyle.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w700),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail Profil",
          style: ijoStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(22),
        child: Column(
          children: [bagianHeader(), bagianContent()],
        ),
      ),
    );
  }
}
