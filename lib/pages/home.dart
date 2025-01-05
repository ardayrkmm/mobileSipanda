import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/BalaiKonservasi.dart';
import 'package:mobilecapstone/models/HewanModel.dart';
import 'package:mobilecapstone/models/Kategori.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/listBalai.dart';
import 'package:mobilecapstone/pages/listHewan.dart';
import 'package:mobilecapstone/pages/profil.dart';
import 'package:mobilecapstone/services/BalaiKonservasiS.dart';
import 'package:mobilecapstone/services/hewanS.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/CardHewan.dart';
import 'package:mobilecapstone/widget/cardBalai.dart';

class Home extends StatefulWidget {
  final UserModel usr;
  const Home({super.key, required this.usr});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> kmplnGmbr = [
    "assets/bn.png",
    "assets/il1.png",
    "assets/il2.png"
  ];
  final HewanService hewanS = HewanService();
  List<KategoriM> ktgr = [];
  final Balaikonservasis balais = Balaikonservasis();
  List<BalaiKonservasi> balai = [];
  @override
  void initState() {
    super.initState();
    ambilData();
    ambilDataBalai();
  }

  Future<void> ambilData() async {
    try {
      List<KategoriM> dt = await hewanS.ambilDataKategori();
      print("Data yang diambil: $dt");
      setState(() {
        ktgr = dt;
      });
    } catch (e) {
      print("error : $e");
    }
  }

  Future<void> ambilDataBalai() async {
    try {
      List<BalaiKonservasi> dtas = await balais.ambilDataBalai();
      print("Data yang diambil: $dtas");
      print("URL Profil: ${widget.usr.imgProfil}");
      setState(() {
        balai = dtas;
      });
    } catch (e) {
      print("error : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget Header() {
      String ucapan() {
        final jam = DateTime.now().hour;

        if (jam >= 0 && jam < 12) {
          return "Selamat Pagi ⛅";
        } else if (jam >= 12 && jam < 18) {
          return "Selamat Siang ☀️";
        }
        {
          return "Selamat Malam 🌕";
        }
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi, ${widget.usr.nama}",
              style:
                  ijoStyle.copyWith(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Text(
              ucapan(),
              style: ijoStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff888888)),
            ),
            SizedBox(
              height: 28,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: ijo),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/search.png"),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: TextField(
                            style: itemStyle.copyWith(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: "Pencarian..",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Profil(
                          usr: widget.usr,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 47,
                    height: 47,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: widget.usr.imgProfil != null &&
                                widget.usr.imgProfil!.isNotEmpty
                            ? NetworkImage(
                                "${Config.urlBase}/static/gambarUser/${widget.usr.imgProfil!}",
                              )
                            : AssetImage("assets/profilKosong.png")
                                as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(1000),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget Content() {
      Widget Banner() {
        return CarouselSlider(
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            viewportFraction: 1.0, // Full width
            enableInfiniteScroll: true,
          ),
          items: kmplnGmbr.map((e) {
            return Builder(
              builder: (context) => Container(
                margin: EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: AssetImage(e), fit: BoxFit.cover)),
              ),
            );
          }).toList(),
        );
      }

      Widget HewanContent() {
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hewan Dilindungi",
                style: itemStyle.copyWith(
                    fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                width: double.infinity,
                height: 200,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ktgr
                        .map((e) => GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AnimalListPage(
                                          e.id_kategori, e.nama_kategori),
                                    ));
                              },
                              child: CardKategori(
                                k: e,
                              ),
                            ))
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        );
      }

      Widget bagianKonservasi() {
        final ambil4 = balai.take(4).toList();
        return Container(
          margin: EdgeInsets.only(bottom: 20),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Balai Konsevarsi",
                    style: itemStyle.copyWith(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ListBalai(bl: balai),
                      ));
                    },
                    child: Text(
                      "Lihat Semua",
                      style: ijoStyle.copyWith(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                width: double.infinity,
                height: 250,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: ambil4.map((e) {
                      return Cardbalai(k: e);
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        );
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Banner(), HewanContent(), bagianKonservasi()],
        ),
      );
    }

    return Scaffold(
        body: ListView(
      children: [Header(), Content()],
    ));
  }
}
