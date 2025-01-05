import 'package:flutter/material.dart';
import 'package:mobilecapstone/theme.dart';

class spCarusol extends StatelessWidget {
  bool sp1 = false;
  bool sp2;
  bool sp3;

  spCarusol({super.key, this.sp1 = false, this.sp2 = false, this.sp3 = false});

  @override
  Widget build(BuildContext context) {
    Color warna(bool active) {
      return active ? ijo : ijo.withOpacity(0.2);
    }

    double panjang(bool active) {
      return active ? 33 : 7;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: panjang(sp1),
          height: 7,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: warna(sp1), borderRadius: BorderRadius.circular(4)),
        ),
        Container(
          width: panjang(sp2),
          height: 7,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: warna(sp2), borderRadius: BorderRadius.circular(4)),
        ),
        Container(
          width: panjang(sp3),
          height: 7,
          margin: EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
              color: warna(sp3), borderRadius: BorderRadius.circular(4)),
        ),
      ],
    );
  }
}
