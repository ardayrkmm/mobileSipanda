import 'package:flutter/material.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:provider/provider.dart';

class Ubahpassword extends StatefulWidget {
  const Ubahpassword({super.key});

  @override
  State<Ubahpassword> createState() => _UbahpasswordState();
}

class _UbahpasswordState extends State<Ubahpassword> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailc = TextEditingController();
    TextEditingController kode = TextEditingController();
    TextEditingController kataSandi = TextEditingController();
    TextEditingController KonfirmasiKataSandi = TextEditingController();
    final authProvider = Provider.of<authP>(context);
    Future<void> mintaToken() async {
      final email = emailc.text;
      final result = await authProvider.mintaToken(email);

      if (result["success"]) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Perhatian Kode Verifikasi",
                style: ijoStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              content: Text(
                "Kode verifikasi Sudah di pesan email, silahkan cek",
                style: ijoStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Menutup dialog
                  },
                  child: Text("Tutup"),
                ),
              ],
            );
          },
        );
      }
    }

    Future<void> ubahPassword() async {
      final hasil = await authProvider.resetPassword(
          emailc.text, kode.text, kataSandi.text, KonfirmasiKataSandi.text);

      if (hasil["success"]) {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                "Kamu Berhasil!",
                style: ijoStyle.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              content: Text(
                "Kamu berhasil mengubah password",
                style: ijoStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Menutup dialog
                    Navigator.of(context).pop();
                  },
                  child: Text("Tutup"),
                ),
              ],
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Ubah Password",
            style: ijoStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          )),
      body: Padding(
        padding: EdgeInsets.all(22),
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Email",
                        style: ijoStyle.copyWith(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        onTap: mintaToken,
                        child: Text(
                          "Minta Kode",
                          textAlign: TextAlign.end,
                          style: orenStyle.copyWith(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 3, left: 16, right: 16),
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ijo)),
                    child: TextField(
                      controller: emailc,
                      decoration: InputDecoration(
                          hintText: "Masukan Email",
                          hintStyle: itemStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kode Verifikasi",
                    style: ijoStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 3, left: 16, right: 16),
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ijo)),
                    child: TextField(
                      controller: kode,
                      decoration: InputDecoration(
                          hintText: "Masukan Kode Verivikasi",
                          hintStyle: itemStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kata Sandi Lama",
                    style: ijoStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 3, left: 16, right: 16),
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ijo)),
                    child: TextField(
                      controller: kataSandi,
                      decoration: InputDecoration(
                          hintText: "Masukan Kata Sandi Lama",
                          hintStyle: itemStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Kata Sandi Baru",
                    style: ijoStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: 3, left: 16, right: 16),
                    height: 44,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ijo)),
                    child: TextField(
                      controller: KonfirmasiKataSandi,
                      decoration: InputDecoration(
                          hintText: "Masukan Kata Sandi Baru",
                          hintStyle: itemStyle.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none),
                    ),
                  )
                ],
              ),
            ),
            btnBaru(
              h: 44,
              w: double.infinity,
              fn: ubahPassword,
              nama: "Ubah Sekarang",
            )
          ],
        ),
      ),
    );
  }
}
