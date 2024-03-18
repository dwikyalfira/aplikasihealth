import 'package:aplikasi_health/screen_page/page_login.dart';
import 'package:aplikasi_health/screen_page/page_pegawai.dart';
import 'package:aplikasi_health/screen_page/page_profile.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi_health/screen_page/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: PageLogin(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class PageHome extends StatefulWidget {
  const PageHome({super.key});

  @override
  State<PageHome> createState() => _State();
}

class _State extends State<PageHome> with SingleTickerProviderStateMixin {
  late TabController tabController;
  // proses do in background
  // initState : proses di background yang dilakukan sebelum view dipanggil
  // state : proses di background yang dilakukan saat perubahan view

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: tabController,
        children: const [PageTabView(), PageTabView(), PagePegawai(), PageProfile()],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 81,
        child: TabBar(
            isScrollable: true,
            labelColor: Colors.green,
            unselectedLabelColor: Colors.grey,
            controller: tabController,
            tabs: const [
              Tab(
                text: "Home",
                icon: Icon(Icons.home_rounded),
              ),
              Tab(
                text: "Galeri",
                icon: Icon(Icons.insert_photo_rounded),
              ),
              Tab(
                text: "Pegawai",
                icon: Icon(Icons.supervised_user_circle_rounded),
              ),
              Tab(
                text: "Profil",
                icon: Icon(Icons.person),
              ),
            ]),
      ),
    );
  }
}

class PageTabView extends StatelessWidget {
  const PageTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: const Text('Page Registrasi'),
      ),
      body: const Center(
        child: Text('Ini adalah Page Tab Bar Setelah di Klik'),
      ),
    );
  }
}
