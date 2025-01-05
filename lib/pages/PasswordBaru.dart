import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/login.dart';
import 'package:mobilecapstone/pages/register.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mobilecapstone/services/authS.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:provider/provider.dart';

class PasswordBaru extends StatefulWidget {
  String email;
  String token;
  PasswordBaru({super.key, required this.email, required this.token});

  @override
  State<PasswordBaru> createState() => _PasswordBaruState();
}

class _PasswordBaruState extends State<PasswordBaru> {
  @override
  Widget build(BuildContext context) {
    final password = TextEditingController();
    final password2 = TextEditingController();

    final authProvider = Provider.of<authP>(context);

    Future<void> ubahPassword() async {
      final hasil = await authProvider.resetPassword(
          widget.email, widget.token, password.text, password2.text);

      if (hasil["success"]) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
          (route) => false,
        ); // Kembali ke halaman awal
      }
    }

    Widget bagianHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password Baru",
            style:
                orenStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Buat password baru",
            style:
                ijoStyle.copyWith(fontSize: 16, fontWeight: FontWeight.normal),
          )
        ],
      );
    }

    Widget bagianForm() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password Baru",
                  style: ijoStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ijo, width: 1)),
                  height: 44,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: double.infinity,
                        padding: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/Lock.png",
                              width: 24,
                              height: 24,
                            ),
                            Container(
                              width: 2,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: ijo),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          style: itemStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          controller: password,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukan Password",
                              hintStyle: itemStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: double.infinity,
                        padding: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          "assets/Blind.png",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Konfirmasi Password",
                  style: ijoStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: ijo, width: 1)),
                  height: 44,
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: double.infinity,
                        padding: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/Lock.png",
                              width: 24,
                              height: 24,
                            ),
                            Container(
                              width: 2,
                              height: 20,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: ijo),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          style: itemStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          controller: password2,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukan Password",
                              hintStyle: itemStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: double.infinity,
                        padding: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(),
                        child: Image.asset(
                          "assets/Blind.png",
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      );
    }

    Widget bagianButton() {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              btnBaru(
                w: double.infinity,
                h: 44,
                fn: ubahPassword,
                nama: "Dapatkan Kode",
              ),
            ],
          ));
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [bagianHeader(), bagianForm(), bagianButton()],
        ),
      ),
    );
  }
}
