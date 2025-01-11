import 'package:flutter/material.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/DetailProfil.dart';
import 'package:mobilecapstone/pages/UbahPassword.dart';
import 'package:mobilecapstone/pages/UpdateProfil.dart';
import 'package:mobilecapstone/pages/login.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:provider/provider.dart';

class Profil extends StatelessWidget {
  UserModel usr;
  Profil({super.key, required this.usr});

  @override
  Widget build(BuildContext context) {
    Widget bagianHeader() {
      return Container(
        margin: EdgeInsets.all(22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 136,
              height: 136,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2000),
                  image: DecorationImage(
                      image: NetworkImage(
                        "${Config.urlBase}/static/gambarUser/${usr.imgProfil!}",
                      ),
                      fit: BoxFit.cover)),
            ),
            SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  usr.nama,
                  style: ijoStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  usr.email,
                  style: ijoStyle.copyWith(
                      fontSize: 14, fontWeight: FontWeight.w400),
                ),
                GestureDetector(
                  key: Key("halUpdate"),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Updateprofil(
                        usr: usr,
                      ),
                    ));
                  },
                  child: Container(
                    width: 127,
                    height: 24,
                    decoration: BoxDecoration(
                      color: ijo,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Center(
                      child: Text(
                        'Edit Profil',
                        style: putihStyle.copyWith(
                            fontSize: 12, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      );
    }

    Widget bagianContent() {
      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => DetailProfil(
                    usr: usr,
                  ),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/profil.png"))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Detail Profil',
                        style: ijoStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: ijo,
                    size: 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Ubahpassword(),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/kunci.png"))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Ubah Password',
                        style: ijoStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: ijo,
                    size: 30,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/keluar.png"))),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Hapus Akun',
                      style: ijoStyle.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                Icon(
                  Icons.arrow_right,
                  color: ijo,
                  size: 30,
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                final authProvider = Provider.of<authP>(context, listen: false);

                authProvider.logout();
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Login(),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/keluar.png"))),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Keluar',
                        style: ijoStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                  Icon(
                    Icons.arrow_right,
                    color: ijo,
                    size: 30,
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: ijoStyle.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [bagianHeader(), bagianContent()],
      ),
    );
  }
}
