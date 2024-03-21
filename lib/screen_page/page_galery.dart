import 'package:flutter/material.dart';

class PageGallery extends StatefulWidget {
  const PageGallery({super.key});

  @override
  State<PageGallery> createState() => _PageGalleryState();
}

class _PageGalleryState extends State<PageGallery> {

  List<Map<String, dynamic>> listMovie = [
    {
      "judul": "Bedah Transparan China",
      "gambar": "bedahtransparan.jpg",
    },
    {
      "judul": "Ginjal",
      "gambar": "ginjal.jpg",
    },
    {
      "judul": "Imunisasi Anak",
      "gambar": "imunisasi-anak.jpeg",
    },
    {
      "judul": "Stroke",
      "gambar": "stroke.jpg",
    },
    {
      "judul": "Struktur Ginjal",
      "gambar": "strukturginjal.jpg",
    },
    {
      "judul": "Minuman Panas ",
      "gambar": "minuman.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Gallery Photo'),
      ),

      body: GridView.builder(
        itemCount: listMovie.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
              // Navigate to detail page without price
              Navigator.push(context, MaterialPageRoute(builder: (context) => PageDetailMovie(listMovie[index]['judul'], listMovie[index]['gambar'])));
            },
            child: Padding(
              padding: EdgeInsets.all(8),
              child: GridTile(
                footer: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: Colors.black54),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('${listMovie[index]['judul']}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                ),
                child: Image.asset('images/${listMovie[index]['gambar']}',
                  fit: BoxFit.contain,
                  height: 185,
                  width: 185,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PageDetailMovie extends StatelessWidget {
  // Titles and image path are passed
  final String itemJudul, itemGambar;
  const PageDetailMovie(this.itemJudul, this.itemGambar, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${itemJudul}'),
        backgroundColor: Colors.blueAccent,
      ),

      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset('images/${itemGambar}',
                  fit: BoxFit.contain,
                ),
                // Price section removed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
