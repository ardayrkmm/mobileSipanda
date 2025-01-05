import 'package:flutter/material.dart';
import 'package:mobilecapstone/theme.dart';

class btnBaru extends StatelessWidget {
  double w, h;
  String nama;
  final VoidCallback? fn;
  btnBaru({super.key, this.h = 0, this.nama = '', this.w = 0, this.fn});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fn,
      child: Container(
        width: w,
        height: h,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(8), color: ijo),
        child: Center(
          child: Text(
            nama,
            style:
                putihStyle.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
