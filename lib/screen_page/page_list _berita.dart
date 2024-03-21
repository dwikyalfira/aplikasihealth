import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:aplikasi_health/model/model_berita.dart';
import 'package:aplikasi_health/screen_page/page_detail_berita.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({Key? key}) : super(key: key);

  @override
  _PageListBeritaState createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  late Future<List<Datum>?> _beritaFuture;
  late List<Datum> _filteredBerita = [];
  late List<Datum> _allBerita = [];

  @override
  void initState() {
    super.initState();
    _beritaFuture = getBerita();
  }

  Future<List<Datum>?> getBerita() async {
    try {
      final response = await http.get(Uri.parse('http://localhost/aplikasihealth/getBerita.php'));
      if (response.statusCode == 200) {
        final beritaData = modelBeritaFromJson(response.body).data;
        setState(() {
          _allBerita = beritaData ?? [];
          _filteredBerita = _allBerita;
        });
        return beritaData;
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load data: $e');
    }
  }

  void _filterBerita(String query) {
    setState(() {
      _filteredBerita = _allBerita.where((berita) {
        return berita.judul!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterBerita,
              decoration: InputDecoration(
                hintText: 'Search Berita...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            child: _buildBeritaList(),
          ),
        ],
      ),
    );
  }

  Widget _buildBeritaList() {
    if (_filteredBerita.isEmpty) {
      return Center(child: Text('No data available'));
    } else {
      return ListView.builder(
        itemCount: _filteredBerita.length,
        itemBuilder: (context, index) {
          Datum data = _filteredBerita[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => PageDetailBerita(data)),
              );
            },
            child: Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        'http://localhost/aplikasihealth/gambar/${data.gambarBerita}',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text('Image not available'));
                        },
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      data.judul ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      data.isiBerita ?? '',
                      maxLines: 2,
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }
  }
}
