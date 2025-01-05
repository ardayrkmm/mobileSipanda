import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/sp3.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:mobilecapstone/widget/spCarusol.dart';

class Sp2 extends StatelessWidget {
  const Sp2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(28),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 354,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/sp1.png"))),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Informasi",
              style:
                  orenStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Memberikan pengetahuan tentang \nhewan yang di lindungi di indonesia",
              style: ijoStyle.copyWith(
                  fontSize: 20, fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 30,
            ),
            spCarusol(
              sp2: false,
              sp3: false,
              sp1: true,
            ),
            SizedBox(
              height: 20,
            ),
            btnBaru(
              w: double.infinity,
              h: 44,
              nama: "Selanjutnya",
              fn: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Sp3(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: animation.drive(
                            Tween(begin: Offset(1.0, 0.0), end: Offset.zero)
                                .chain(CurveTween(curve: Curves.easeInOut))),
                        child: child,
                      );
                    },
                  ),
                  (Route<dynamic> route) => false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
