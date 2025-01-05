import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobilecapstone/models/LaporModel.dart';
import 'package:mobilecapstone/pages/Berhasil.dart';
import 'package:mobilecapstone/providers/LaporanP.dart';
import 'package:mobilecapstone/widget/errorPesan.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatelessWidget {
  // String imgUrlH;

  @override
  Widget build(BuildContext context) {
    TextEditingController nama = TextEditingController();
    TextEditingController nomerHP = TextEditingController();
    TextEditingController alamat = TextEditingController();
    TextEditingController keterangan = TextEditingController();
    final isTestEnvironment = const bool.fromEnvironment('flutter.test');
    Future<void> laporansp() async {
      try {
        final laporans = Provider.of<Laporanp>(context, listen: false);

        LaporModel laporan = LaporModel(
          id: "",
          status: "sedang_di_proses",
          namaLapor: nama.text,
          nomerHp: nomerHP.text,
          alamat: alamat.text,
          keterangan: keterangan.text,
          maps: "",
        );

        final hasil = await laporans.buatLaporan(laporan);
        if (hasil['success'] == true) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Berhasil()),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Gagal'),
              content: Text(hasil['message'] ?? 'Terjadi kesalahan'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Laporkan",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff014224),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Container(
            //   width: double.infinity,
            //   height: 150,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(10),
            //   ),
            //   child: isTestEnvironment
            //       ? Placeholder(fallbackHeight: 100, fallbackWidth: 100)
            //       : Image.network(
            //           imgUrlH,
            //           fit: BoxFit.cover,
            //         ),
            // ),
            // SizedBox(height: 16),
            TextField(
              controller: nama,
              decoration: InputDecoration(
                labelText: "Nama",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: nomerHP,
              decoration: InputDecoration(
                labelText: "No Hp",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(height: 16),
            TextField(
              controller: alamat,
              decoration: InputDecoration(
                labelText: "Detail Alamat",
                hintText:
                    "Contoh: Jl. Mawar Rt.003/008 Desa Kembang Kecamatan Pohon",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: keterangan,
              decoration: InputDecoration(
                labelText: "Keterangan",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: laporansp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff014224),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  "Laporkan",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
