import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/HalamanLapor.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';

class ScanPage extends StatelessWidget {
  String status;
  String imgUrl;
  ScanPage({super.key, required this.imgUrl, required this.status});

  @override
  Widget build(BuildContext context) {
    cekBtn() {
      if (status == "Dilindungi") {
        return btnBaru(
          w: double.infinity,
          h: 44,
          fn: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReportScreen(),
            ));
          },
          nama: "Laporkan",
        );
      } else {
        return SizedBox();
      }
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: ijo,
          ),
        ),
        title: Text(
          "Deteksi",
          style: ijoStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 368,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(imgUrl), fit: BoxFit.cover)),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      status,
                      style: ijoStyle.copyWith(
                          fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    btnBaru(
                      w: double.infinity,
                      h: 44,
                      fn: () {},
                      nama: "Kembali",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    cekBtn()
                  ],
                ),
              )
            ],
          )),
    );
  }
}
