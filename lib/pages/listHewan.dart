import 'package:flutter/material.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/HewanModel.dart';
import 'package:mobilecapstone/pages/detailpage.dart';
import 'package:mobilecapstone/services/hewanS.dart';

class AnimalListPage extends StatefulWidget {
  String id_kategori;
  String nama_kategori;

  AnimalListPage(this.id_kategori, this.nama_kategori);

  @override
  State<AnimalListPage> createState() => _AnimalListPageState();
}

class _AnimalListPageState extends State<AnimalListPage> {
  final HewanService hewanS = HewanService();
  List<hewanModel> hwn = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ambilData();
  }

  Future<void> ambilData() async {
    try {
      List<hewanModel> dt = await hewanS.ambilDataHewan(widget.nama_kategori);
      setState(() {
        hwn = dt;
      });
    } catch (e) {
      print("error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Hewan"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Cari Hewan',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: hwn.length,
              itemBuilder: (context, index) {
                final he = hwn[index];
                return AnimalCard(
                  hwn: he,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AnimalCard extends StatelessWidget {
  hewanModel hwn;
  AnimalCard({Key? key, required this.hwn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailHewan(
            hwn: hwn,
          ),
        ));
      },
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                    "${Config.urlBase}/static/gambarUser/${hwn.urlGambar}",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, size: 80); // Gambar atau ikon error
                }),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hwn.nama,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      hwn.populasi.toString(),
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
