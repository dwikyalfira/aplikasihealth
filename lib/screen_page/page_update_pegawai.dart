import 'package:aplikasi_health/screen_page/page_list_pegawai.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../model/model_pegawai.dart';

class PageUpdatePegawai extends StatefulWidget {
  final Datum data;

  const PageUpdatePegawai(this.data, {super.key});

  @override
  State<PageUpdatePegawai> createState() => _PageUpdatePegawaiState();
}

class _PageUpdatePegawaiState extends State<PageUpdatePegawai> {
  TextEditingController id = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController no_bp = TextEditingController();
  TextEditingController no_hp = TextEditingController();
  TextEditingController email = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();

  bool isLoading = false;

  Future updatePegawai() async {
    final res = await http.post(
      Uri.parse("http://localhost/aplikasihealth/updatePegawai.php"),
      body: {
        "id": id.text, // Pass the id of the employee to update
        "nama": nama.text,
        "no_bp": no_bp.text,
        "no_hp": no_hp.text,
        "email": email.text,
      },
    );

    if (res.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id.text = widget.data.id;
    nama.text = widget.data.nama;
    no_bp.text = widget.data.noBp;
    no_hp.text = widget.data.noHp;
    email.text = widget.data.email;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Update Pegawai',
            style: GoogleFonts.merriweather(
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ))
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: keyForm,
          child: Column(
            children: [
              TextFormField(
                controller: nama,
                style: TextStyle(color: Colors.black.withOpacity(0.8)),
                decoration: InputDecoration(
                  hintText: "Nama",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: no_bp,
                style: TextStyle(color: Colors.black.withOpacity(0.8)),
                decoration: InputDecoration(
                  hintText: "NO BP",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: no_hp,
                style: TextStyle(color: Colors.black.withOpacity(0.8)),
                decoration: InputDecoration(
                  hintText: "NO HP",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: email,
                style: TextStyle(color: Colors.black.withOpacity(0.8)),
                decoration: InputDecoration(
                  hintText: "EMAIL",
                  hintStyle: TextStyle(color: Colors.black.withOpacity(0.8)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                ),
              ),
              SizedBox(height: 25),
              Center(
                child: isLoading
                    ? CircularProgressIndicator()
                    : MaterialButton(
                  minWidth: 150,
                  height: 45,
                  color: Colors.white,
                  onPressed: () async {
                    setState(() {
                      isLoading = true; // Set isLoading to true before adding/updating data
                    });
                    if (keyForm.currentState!.validate()) {
                      await updatePegawai(); // Await the createPegawai function
                    }
                    setState(() {
                      isLoading = false; // Set isLoading back to false after adding/updating data
                    });
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => PageListPegawai()),(route) => false,
                    );
                  },
                  child: Text(
                    "SIMPAN",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}