import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/KodeVerifikasi.dart';
import 'package:mobilecapstone/pages/register.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mobilecapstone/services/authS.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:provider/provider.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final auth = Auths();
  final _emailC = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<authP>(context);
    Future<void> mintaToken() async {
      final email = _emailC.text;
      final result = await authProvider.mintaToken(email);

      if (result["success"]) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => KodeVerifikasi(
            email: email,
          ),
        ));
      }
    }

    Widget bagianHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Reset",
            style:
                orenStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Masukan email dahulu, untuk mendapatkan token",
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
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: ijoStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                              "assets/email.png",
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
                          controller: _emailC,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukan Email",
                              hintStyle: itemStyle.copyWith(
                                fontSize: 16,
                                fontWeight: FontWeight.w300,
                              ),
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
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
                fn: mintaToken,
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
