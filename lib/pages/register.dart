import 'package:flutter/material.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/login.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mobilecapstone/services/SessionService.dart';
import 'package:mobilecapstone/services/authS.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _emailC = TextEditingController(text: "");

  final _namaC = TextEditingController(text: "");

  final _passowrdC = TextEditingController(text: "");

  final _noTelp = TextEditingController(text: "");

  final auth = Auths();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<authP>(context);
    final Session = SessionService();
    bool lihatText = true;
    void _register() async {
      String email = _emailC.text;
      String nama = _namaC.text;
      String password = _passowrdC.text;
      String notelp = _noTelp.text;

      if (email.isEmpty || nama.isEmpty || password.isEmpty || notelp.isEmpty) {
        print("Wajib Di Isi Semua");
        return;
      }
      if (email.isEmpty || nama.isEmpty || password.isEmpty || notelp.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Semua field harus diisi!')),
        );
        return;
      }

      try {
        UserModel newUser = UserModel(
          nama: nama,
          email: email,
          password: password,
          noTelp: notelp,
        );

        final result = await authProvider.buatAkun(newUser);

        if (result['success'] == true) {
          final userDs = result['user'];
          await Session.saveUser(UserModel(
              id: userDs['id'],
              email: userDs['email'],
              nama: userDs['nama'],
              noTelp: userDs['no_telp'],
              password: ''));
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
              'Registrasi berhasil!',
              key: Key("berhasil"),
            )),
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => Login(
                      key: Key("halamanLogin"),
                    )),
          );
        } else {
          print(result['message']);
        }
      } catch (error) {
        print("Registration error: $error");
      }
    }

    Widget bagianHeader() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Register",
            style:
                orenStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            "Buat akun dulu ya!",
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
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Nama",
                  style: ijoStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                              "assets/User.png",
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
                          controller: _namaC,
                          style: itemStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          key: Key("inputNama"),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukan Nama",
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
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Email",
                  style: ijoStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                          key: Key("inputEmail"),
                          style: itemStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
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
            margin: EdgeInsets.only(
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No Telp",
                  style: ijoStyle.copyWith(
                      fontSize: 20, fontWeight: FontWeight.bold),
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
                          controller: _noTelp,
                          key: Key("inputNotelp"),
                          style: itemStyle.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Masukan No Telp",
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
            margin: EdgeInsets.only(
              top: 10,
            ),
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
              btnBaru(
                key: Key("btnRegister"),
                w: double.infinity,
                h: 44,
                fn: _register,
                nama: "Register",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sudah punya akun?",
                    style: itemStyle.copyWith(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  GestureDetector(
                    child: Text(
                      "Login",
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
