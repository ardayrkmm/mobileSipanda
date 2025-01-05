import 'package:flutter/material.dart';
import 'package:mobilecapstone/theme.dart';

class Pesan extends StatelessWidget {
  String pesan;
  bool bot;
  Pesan({super.key, required this.pesan, this.bot = false});

  @override
  Widget build(BuildContext context) {
    BorderRadius br() {
      if (bot == false) {
        return BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        );
      } else {
        return BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
          topRight: Radius.circular(30),
        );
      }
    }

    Color warna() {
      if (bot == false) {
        return ijo;
      } else {
        return Color(0xffEEEEEE);
      }
    }

    TextStyle warnaTxt() {
      if (bot == false) {
        return putihStyle;
      } else {
        return ijoStyle;
      }
    }

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 18),
      child: Row(
        mainAxisAlignment:
            bot == false ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: EdgeInsets.symmetric(horizontal: 22, vertical: 18),
              decoration: BoxDecoration(borderRadius: br(), color: warna()),
              child: Text(
                pesan,
                style: warnaTxt()
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
          )
        ],
      ),
    );
  }
}
