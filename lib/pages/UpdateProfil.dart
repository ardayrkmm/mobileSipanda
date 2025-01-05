import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobilecapstone/config.dart';
import 'package:mobilecapstone/models/UserModel.dart';
import 'package:mobilecapstone/pages/Mainpage.dart';
import 'package:mobilecapstone/pages/profil.dart';
import 'package:mobilecapstone/providers/authP.dart';
import 'package:mobilecapstone/services/SessionService.dart';
import 'package:mobilecapstone/theme.dart';
import 'package:mobilecapstone/widget/btnBaru.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Updateprofil extends StatefulWidget {
  final UserModel usr;
  Updateprofil({super.key, required this.usr});

  @override
  State<Updateprofil> createState() => _UpdateprofilState();
}

class _UpdateprofilState extends State<Updateprofil> {
  File? file;

  Future<void> ambilGambar(ImageSource gmbr) async {
    final ambil = await ImagePicker().pickImage(source: gmbr);
    if (ambil != null) {
      setState(() {
        file = File(ambil.path);
      });
    }
  }

  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController telp = TextEditingController();

  @override
  void initState() {
    super.initState();
    nama.text = widget.usr.nama ?? '';
    email.text = widget.usr.email ?? '';
    telp.text = widget.usr.noTelp ?? '';
  }

  Future<void> update() async {
    final authProvider = Provider.of<authP>(context, listen: false);

    final response = await authProvider.updateProfil(
      widget.usr.id,
      nama.text.trim(),
      email.text.trim(),
      telp.text.trim(),
      file, // Mengirimkan file gambar langsung
    );

    if (response['status'] == 'success') {
      UserModel updatedUser = authProvider.currentUser!;
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Mainpage(usr: updatedUser),
        ),
        (route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(response['message'] ?? 'Gagal memperbarui profil')),
      );
    }
  }

  Future<void> pilihanGambar() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Pilih dari Galeri"),
              onTap: () {
                Navigator.pop(context);
                ambilGambar(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera_alt),
              title: Text("Ambil dari Kamera"),
              onTap: () {
                Navigator.pop(context);
                ambilGambar(ImageSource.camera);
              },
            ),
          ],
        );
      },
    );
  }

  Widget bagianHeader() {
    return Center(
      child: GestureDetector(
        onTap: pilihanGambar,
        child: Container(
          width: 250,
          height: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10000),
            image: DecorationImage(
              image: file != null
                  ? FileImage(file!)
                  : NetworkImage(
                          "${Config.urlBase}/static/gambarUser/${widget.usr.imgProfil!}")
                      as ImageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget bagianKonten() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          inputField("Nama", nama),
          inputField("Email", email),
          inputField("Telepon", telp),
          SizedBox(height: 20),
          btnBaru(
            h: 44,
            w: double.infinity,
            nama: "Simpan Perubahan",
            fn: update,
          ),
        ],
      ),
    );
  }

  Widget inputField(String label, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: itemStyle.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 44,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintStyle: ijoStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: black),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Update Profil",
          style: ijoStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(22),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [bagianHeader(), bagianKonten()],
          ),
        ),
      ),
    );
  }
}
