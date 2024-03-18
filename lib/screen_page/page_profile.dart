import 'package:aplikasi_health/screen_page/page_edit_profile.dart';
import 'package:aplikasi_health/screen_page/page_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/check_session.dart';

class PageProfile extends StatefulWidget {
  const PageProfile({Key? key}) : super(key: key);

  @override
  State<PageProfile> createState() => _PageProfileState();
}

class _PageProfileState extends State<PageProfile> {
  String? id, fullname, username, email;

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      fullname = pref.getString("fullname") ?? '';
      username = pref.getString("username") ?? '';
      email = pref.getString("email") ?? '';
      print('username $username');
      print('fullname $fullname');
      print('id $id');
      print('$email');
    });
  }

  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: 'Edit Profile',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const PageEditProfile()));
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              child: CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage('images/user.png'),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text('Fullname',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(fullname ?? ''),
              leading: Icon(CupertinoIcons.person),
            ),
            ListTile(
              title: Text('Username',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(username ?? ''),
              leading: Icon(CupertinoIcons.personalhotspot),
            ),
            ListTile(
              title: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(id ?? ''),
              leading: Icon(CupertinoIcons.number_circle),
            ),
            ListTile(
              title: Text('Email', style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(email ?? ''),
              leading: Icon(CupertinoIcons.mail),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                session.clearSession();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const PageLogin()),
                  (route) => false,
                );
              },
              icon: Icon(Icons.logout_rounded),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


