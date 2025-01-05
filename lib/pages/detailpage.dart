import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/HewanModel.dart';

import 'package:mobilecapstone/theme.dart';

class DetailHewan extends StatefulWidget {
  hewanModel hwn;
  DetailHewan({required this.hwn});
  @override
  State<DetailHewan> createState() => _DetailHewanState();
}

class _DetailHewanState extends State<DetailHewan> {
  @override
  Widget build(BuildContext context) {
    Widget bagianGambar() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        width: double.infinity,
        height: 450,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                        "${Config.urlBase}/static/gambarUser/${widget.hwn.urlGambar}")
                    as ImageProvider,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter)),
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
                    "Detail Page",
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
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
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
                    widget.hwn.nama,
                    style: putihStyle.copyWith(
                        fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "(${widget.hwn.namaLatin})",
                    style: orenStyle.copyWith(
                        fontSize: 15, fontWeight: FontWeight.w400),
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
                          widget.hwn.deskripsi,
                          textAlign: TextAlign.justify,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          style: putihStyle.copyWith(
                              fontSize: 14, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Row(
                    children: [
                      Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Populasi",
                                style: orenStyle.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 70,
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    widget.hwn.populasi.toString(),
                                    style: ijoStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Habitat",
                                style: orenStyle.copyWith(
                                    fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 18),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4)),
                                child: Center(
                                  child: Text(
                                    widget.hwn.habitat,
                                    style: ijoStyle.copyWith(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  Container(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Status",
                            style: orenStyle.copyWith(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 180,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4)),
                            child: Center(
                              child: Text(
                                widget.hwn.status,
                                style: ijoStyle.copyWith(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 1.5),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: ExpansionTile(
                        title: Text(
                          'Ciri-ciri Hewan',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: ijo),
                        ),
                        childrenPadding: EdgeInsets.all(8.0),
                        children: widget.hwn.ciriCiri!
                            .asMap()
                            .entries
                            .map((entry) => Container(
                                  margin: EdgeInsets.only(bottom: 14),
                                  child: Text(
                                    '${entry.key + 1}. ${entry.value.ciri}',
                                    style: ijoStyle.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ))
                            .toList()),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    return Scaffold(
      body: Stack(
        children: [bagianGambar(), bagianContent()],
      ),
      // body: ListView(
      //   children: [
      //   Image.asset("assets/bn.png"),
      //   SizedBox(height: 15),
      //   Container(
      //     padding: EdgeInsets.all(20),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text(
      //           "Gajah Sumatra",
      //           style: TextStyle(
      //               color: Color(0xff014224), fontWeight: FontWeight.bold),
      //         ),
      //         Text(
      //           "(Elephas maximus sumatranus)",
      //           style: TextStyle(color: Color(0xff014224)),
      //         ),
      //         SizedBox(height: 15),
      //         Container(
      //           padding: EdgeInsets.only(left: 10),
      //           child: Text(
      //             "         Gajah Sumatera (Elephas maximus sumatranus) adalah subspesies gajah Asia yang hidup di pulau Sumatera. Gajah Sumatera hidup di hutan dataran rendah di Provinsi Riau, Sumatera Barat, dan Lampung. Gajah Sumatera hidup berkelompok, dan satu kelompok bisa terdiri dari tiga hingga empat keluarga. Gajah Sumatera merupakan hewan yang terancam punah akibat dibunuh manusia dan perubahan habitat. Gajah sangat selektif dalam memilih habitatnya.",
      //             textAlign: TextAlign.justify,
      //           ),
      //         ),
      //         SizedBox(height: 15),
      //         Container(
      //           decoration: BoxDecoration(
      //             border: Border.all(color: Color(0xff3B3A3A), width: 1.5),
      //             borderRadius: BorderRadius.circular(20.0),
      //           ),
      //           child: ExpansionTile(
      //             title: Text(
      //               'Ciri-ciri Hewan',
      //               style: TextStyle(
      //                   fontWeight: FontWeight.bold, color: Color(0xff014224)),
      //             ),
      //             childrenPadding: EdgeInsets.all(8.0), // Add children padding
      //             children: [
      //               Text(
      //                 '1. Ukuran: Gajah Sumatera memiliki tinggi 2–3 meter dan berat 3–5 ton.\n'
      //                 '2. Kuping: Kuping gajah Sumatera lebih kecil dan berbentuk segitiga.\n'
      //                 '3. Gading: Hanya gajah jantan yang memiliki gading yang panjang, sedangkan gajah betina memiliki gading yang pendek atau hampir tidak terlihat.\n'
      //                 '4. Tonjolan: Gajah Sumatera memiliki dua tonjolan di bagian atas kepalanya.\n',
      //                 style: TextStyle(height: 1.5),
      //               ),
      //             ],
      //           ),
      //         ),
      //         SizedBox(height: 15),
      //         Container(
      //           decoration: BoxDecoration(
      //             border: Border.all(color: Color(0xff3B3A3A), width: 1.5),
      //             borderRadius: BorderRadius.circular(20.0),
      //           ),
      //           child: ExpansionTile(
      //             title: Text(
      //               'Lokasi',
      //               style: TextStyle(
      //                   fontWeight: FontWeight.bold, color: Color(0xff014224)),
      //             ),
      //             childrenPadding: EdgeInsets.all(8.0), // Add children padding
      //             children: [
      //               Text(
      //                 address,
      //                 style: TextStyle(fontSize: 16),
      //               ),
      //               SizedBox(height: 16),
      //               Container(
      //                   height: 200,
      //                   child: FlutterMap(
      //                     options: MapOptions(
      //                       center:
      //                           hewanLocation, // Ganti 'initialCenter' menjadi 'center'
      //                       zoom: 5.0, // Ganti 'initialZoom' menjadi 'zoom'
      //                     ),
      //                     children: [
      //                       TileLayer(
      //                         urlTemplate:
      //                             "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
      //                         subdomains: ['a', 'b', 'c'],
      //                       ),
      //                       MarkerLayer(
      //                         // Gunakan 'MarkerLayer' langsung, bukan 'MarkerLayerWidget'
      //                         markers: [
      //                           Marker(
      //                             point: hewanLocation,
      //                             width: 80.0,
      //                             height: 80.0,
      //                             rotate: true,
      //                             builder: (context) => Icon(
      //                               Icons.location_on,
      //                               color: Colors.red,
      //                               size: 40.0,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   )),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ]),
    );
  }
}
