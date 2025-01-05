import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobilecapstone/models/BalaiKonservasi.dart';
import 'package:mobilecapstone/models/HewanModel.dart';
import 'package:mobilecapstone/config.dart';

import 'package:mobilecapstone/theme.dart';

class DetailBalai extends StatefulWidget {
  BalaiKonservasi balai;
  DetailBalai({required this.balai});
  @override
  State<DetailBalai> createState() => _DetailHewanState();
}

class _DetailHewanState extends State<DetailBalai> {
  @override
  Widget build(BuildContext context) {
    Widget bagianGambar() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        width: double.infinity,
        height: 500,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                        "${Config.urlBase}/static/gambarUser/${widget.balai.gambarBalai}")
                    as ImageProvider,
                fit: BoxFit.cover)),
      );
    }

    Widget bagianContent() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: putih,
                    )),
                Expanded(
                  child: Text(
                    "Detail Balai",
                    textAlign: TextAlign.center,
                    style: putihStyle.copyWith(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 450,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
            decoration: BoxDecoration(
                color: ijo,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80),
                    topRight: Radius.circular(80))),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.balai.namaBalai,
                      style: putihStyle.copyWith(
                          fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Deskripsi",
                      style: putihStyle.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 330,
                          child: Text(
                            widget.balai.deskripsi,
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            style: putihStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Provinsi",
                              style: orenStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              width: 150,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 18),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  widget.balai.provinsi,
                                  style: ijoStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ]),
                    ),
                    Text(
                      "Alamat",
                      style: putihStyle.copyWith(
                          fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 330,
                          child: Text(
                            widget.balai.alamat,
                            textAlign: TextAlign.justify,
                            softWrap: true,
                            overflow: TextOverflow.clip,
                            style: putihStyle.copyWith(
                                fontSize: 14, fontWeight: FontWeight.w300),
                          ),
                        ),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      );
    }

    return Scaffold(
      body: Stack(
        children: [bagianGambar(), bagianContent()],
      ),
    );
  }
}
