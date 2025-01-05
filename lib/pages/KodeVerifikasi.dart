import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/PasswordBaru.dart';
import 'package:mobilecapstone/pages/register.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';

class KodeVerifikasi extends StatefulWidget {
  String email;
  KodeVerifikasi({super.key, required this.email});

  @override
  State<KodeVerifikasi> createState() => _KodeVerifikasiState();
}

class _KodeVerifikasiState extends State<KodeVerifikasi> {
  @override
  Widget build(BuildContext context) {
    final tokens = TextEditingController();
    void verifyToken() {
      final token = tokens.text;

      if (token.isNotEmpty) {
        // Navigasi ke halaman ubah password
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PasswordBaru(
              email: widget.email,
              token: token,
            ),
          ),
        );
      } else {
        final snackBar = SnackBar(content: Text("Token tidak boleh kosong."));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }

    Widget bagianHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Kode Verifikasi",
            style:
                orenStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Kode berada di inbox email",
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
                  "KOde",
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
                  child: TextField(
                    style: itemStyle.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                    controller: tokens,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukan Kode",
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
                fn: verifyToken,
                nama: "Selanjutnya",
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
