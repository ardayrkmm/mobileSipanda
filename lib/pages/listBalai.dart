import 'package:flutter/material.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/BalaiKonservasi.dart';
import 'package:mobilecapstone/models/HewanModel.dart';
import 'package:mobilecapstone/pages/DetailBalai.dart';
import 'package:mobilecapstone/pages/detailpage.dart';
import 'package:mobilecapstone/pages/sp1.dart';
import 'package:mobilecapstone/services/BalaiKonservasiS.dart';
import 'package:mobilecapstone/services/hewanS.dart';

class ListBalai extends StatefulWidget {
  List<BalaiKonservasi> bl;

  ListBalai({required this.bl});

  @override
  State<ListBalai> createState() => _AnimalListPageState();
}

class _AnimalListPageState extends State<ListBalai> {
  final Balaikonservasis Balais = Balaikonservasis();
  List<BalaiKonservasi> balai = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ambilData();
  }

  Future<void> ambilData() async {
    try {
      List<BalaiKonservasi> dt = await Balais.ambilDataBalai();
      setState(() {
        balai = dt;
      });
    } catch (e) {
      print("error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Balai"),
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
                hintText: 'Cari Balai',
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
              itemCount: balai.length,
              itemBuilder: (context, index) {
                final he = balai[index];

                return CardBalai(
                  blai: widget.bl[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CardBalai extends StatelessWidget {
  BalaiKonservasi blai;

  CardBalai({Key? key, required this.blai}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => DetailBalai(
            balai: blai,
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
                    "${Config.urlBase}/static/gambarUser/${blai.gambarBalai}",
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
                      blai.namaBalai,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      blai.alamat,
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
