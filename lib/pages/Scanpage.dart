import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/HalamanLapor.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';

class ScanPage extends StatelessWidget {
  String status;
  String imgUrl;
  Map<String, dynamic> informasiHewan;
  ScanPage(
      {super.key,
      required this.imgUrl,
      required this.status,
      required this.informasiHewan});

  @override
  Widget build(BuildContext context) {
    cekBtn() {
      if (informasiHewan['status'] == "DILINDUNGI") {
        return btnBaru(
          w: double.infinity,
          h: 44,
          fn: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ReportScreen(
                imgUrlH: imgUrl,
              ),
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
        backgroundColor: putih,
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Text(
                        "Status :",
                        style: itemStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Text(
                        informasiHewan['status'],
                        style: itemStyle.copyWith(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    children: [
                      Text(
                        "Habitat :",
                        style: itemStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Flexible(
                        child: Text(
                          informasiHewan['habitat'],
                          softWrap: true,
                          style: itemStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        "Deskripsi :",
                        style: itemStyle.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        width: 14,
                      ),
                      Flexible(
                        child: Text(
                          informasiHewan['description'],
                          softWrap: true,
                          style: itemStyle.copyWith(
                              fontSize: 18, fontWeight: FontWeight.w700),
                        ),
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
            ),
          )),
    );
  }
}
