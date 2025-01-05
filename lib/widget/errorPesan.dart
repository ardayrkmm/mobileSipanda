import 'package:flutter/material.dart';

class errorPesan extends StatelessWidget {
  String judul;
  String deskripsi;
  errorPesan({super.key, required this.judul, required this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(judul),
      content: Text(deskripsi),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("OK"),
        ),
      ],
    );
  }
}
