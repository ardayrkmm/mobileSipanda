import 'package:flutter/material.dart';
import 'package:mobilecapstone/pages/BerhasilFeed.dart';
import 'package:mobilecapstone/providers/sentimeProvider.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:provider/provider.dart';

class SentimentHalaman extends StatelessWidget {
  const SentimentHalaman({super.key});

  @override
  Widget build(BuildContext context) {
    final Sentimen = Provider.of<SentimenProvider>(context);
    TextEditingController komen = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Feedback",
          style: ijoStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Komentar",
              style:
                  ijoStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              padding: EdgeInsets.all(2),
              height: 44,
              decoration: BoxDecoration(
                  border: Border.all(color: ijo, width: 2),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(
                child: TextField(
                  controller: komen,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ),
            btnBaru(
              w: double.infinity,
              h: 44,
              fn: () async {
                if (komen.text.isNotEmpty) {
                  await Sentimen.TambahKomen(komen.text);
                }
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => BerhasilFeed(),
                ));
                komen.clear();
              },
              nama: "Selanjutnya",
            )
          ],
        ),
      ),
    );
  }
}
