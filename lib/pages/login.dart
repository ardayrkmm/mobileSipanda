import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/HalamanScan.dart';
import 'package:mobilecapstone/pages/Mainpage.dart';
import 'package:mobilecapstone/pages/home.dart';
import 'package:mobilecapstone/pages/register.dart';
import 'package:mobilecapstone/pages/resetpassword.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mobilecapstone/services/SessionService.dart';
import 'package:mobilecapstone/services/authS.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailC = TextEditingController(text: "");

  final _passowrdC = TextEditingController(text: "");
  bool lihatText = true;

  final auth = Auths();

  // // @override
  // void login() async {
  //   String email = _emailC.text;

  //   String password = _passowrdC.text;

  //   if (email.isEmpty || password.isEmpty) {
  //     print("Wajib Di Isi Semua");
  //     return;
  //   }

  //   try {
  //     try {
  //       final result = await auth.login(email, password);
  //       print("Respons login dari server: $result");
  //       if (result['status'] == 'success') {
  //         final us = UserModel.fromJson(result['user']);
  //         Navigator.of(context).pushReplacement(
  //           MaterialPageRoute(
  //               builder: (context) => Mainpage(
  //                     usr: us,
  //                   )),
  //         );
  //       } else {
  //         print("Error saat login: ${result['message']}");
  //         // Tampilkan pesan ke user jika diperlukan
  //       }
  //     } catch (error) {
  //       print("Error: $error");
  //     }
  //   } catch (error) {
  //     print("Error saat login: $error");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<authP>(context);

    final Session = SessionService();

    void login() async {
      String email = _emailC.text;

      String password = _passowrdC.text;

      if (email.isEmpty || password.isEmpty) {
        print("Wajib Di Isi Semua");
        return;
      }
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Semua field harus diisi!')),
        );
        return;
      }

      try {
        final user = await authProvider.login(email, password);

        if (user['success'] == true) {
          final us = UserModel.fromJson(user['user']);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  Mainpage(key: Key("halamanMainpage"), usr: us),
            ),
          );
        }
      } catch (error) {
        print("Login error: $error");
      }
    }

    Widget bagianHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login",
            style:
                orenStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Login dahulu agar \nbisa mengakses aplikasi",
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
                          controller: _emailC,
                          style: itemStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          key: Key("inputEmail"),
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
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Password",
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
                          controller: _passowrdC,
                          key: Key("inputPassword"),
                          obscureText: lihatText,
                          style: itemStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
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
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            lihatText = !lihatText;
                          });
                        },
                        child: Container(
                          width: 40,
                          height: double.infinity,
                          padding: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(),
                          child: Image.asset(
                            lihatText ? "assets/lihat.png" : "assets/Blind.png",
                            width: 20,
                            height: 20,
                          ),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Lupa Password?",
                    style: itemStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ResetPassword(),
                      ));
                    },
                    child: Text(
                      "Reset password",
                      style: itemStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7048FF)),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              btnBaru(
                w: double.infinity,
                h: 44,
                fn: login,
                key: Key("tombolLogin"),
                nama: "Login",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Belum punya akun?",
                    style: itemStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Register(),
                      ));
                    },
                    child: Text(
                      "Buat akun",
                      style: itemStyle.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff7048FF)),
                    ),
                  )
                ],
              ),
            ],
          ));
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: Key("halamanLogin"),
      body: Container(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [bagianHeader(), bagianForm(), bagianButton()],
          ),
        ),
      ),
    );
  }
}
