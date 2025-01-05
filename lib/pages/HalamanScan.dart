import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/pages/Scanpage.dart';
import 'package:mobilecapstone/providers/scanProvider.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:provider/provider.dart';

class HalamanScan extends StatefulWidget {
  final CameraController? customController;
  const HalamanScan({super.key, this.customController});

  @override
  State<HalamanScan> createState() => _HalamanScanState();
}

class _HalamanScanState extends State<HalamanScan> {
  CameraController? cmr;
  List<CameraDescription>? camer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    bukaKamera();
  }

  Future<void> bukaKamera() async {
    camer = await availableCameras();
    cmr = CameraController(camer![0], ResolutionPreset.high);
    await cmr!.initialize();
    setState(() {});
  }

  @override
  void dispose() {
    cmr?.dispose();
    super.dispose();
  }

  Future<void> deteksiHewan() async {
    if (cmr == null || !cmr!.value.isInitialized) return;

    try {
      XFile file = await cmr!.takePicture();

      File files = File(file.path);

      final providS = await Provider.of<scanProvider>(context, listen: false);
      final hasil = await providS.tambahGambar(files);
      if (hasil['status'] == 'success') {
        final imgUrl = hasil['url_gambar']; // URL gambar
        final result = hasil['result']; // Hasil deteksi

        // Navigasi ke halaman hasil dengan data gambar dan deteksi
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ScanPage(
              imgUrl: "${Config.urlBase}/${imgUrl}",
              status: result,
            ),
          ),
        );
      } else {
        // Tampilkan pesan error jika proses gagal
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(hasil['message'] ?? 'Gagal memproses gambar')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cmr == null || !cmr!.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      // appBar: AppBar(
      //     centerTitle: true,
      //     leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
      //     title: Text(
      //       "Scan Binatang",
      //       style: ijoStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
      //     )),
      body: Stack(
        children: [
          CameraPreview(cmr!),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: deteksiHewan,
              child: Container(
                margin: EdgeInsets.only(bottom: 70),
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1000),
                  color: putih,
                ),
                child: Icon(
                  Icons.camera,
                  color: ijo,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
