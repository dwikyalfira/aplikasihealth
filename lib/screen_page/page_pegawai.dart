import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/model_user.dart';

class PagePegawai extends StatefulWidget {
  const PagePegawai({super.key});

  @override
  State<PagePegawai> createState() => _PagePegawaiState();
}

class _PagePegawaiState extends State<PagePegawai> {
  bool isLoading = true;
  List<ModelUser> listUser = [];

  Future getUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      var data = jsonDecode(response.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          listUser.add(ModelUser.fromJson(i));
        }
      });
    } catch (e) {
      isLoading = false;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  //do in background
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("List Data User"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: listUser.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PageDetailUser(
                              listUser[index].name,
                              listUser[index].email,
                              listUser[index].username,
                              listUser[index].phone,
                              listUser[index].website,
                              listUser[index].address.street,
                              listUser[index].address.suite,
                              listUser[index].address.city,
                              listUser[index].address.zipcode,
                              listUser[index].company.name,
                              listUser[index].company.catchPhrase,
                              listUser[index].company.bs)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Card(
                    child: ListTile(
                      title: Text(
                        listUser[index].name ?? "",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.red),
                      ),
                      subtitle: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(listUser[index].email ?? ""),
                          Text(listUser[index].address.street ?? ""),
                          Text('Company : ${listUser[index].company}' ?? ""),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class PageDetailUser extends StatelessWidget {
  final String nama,
      email,
      username,
      phone,
      website,
      street,
      suite,
      city,
      zipCode,
      company,
      companyCatchPhrase,
      companyBs;
  const PageDetailUser(
      this.nama,
      this.email,
      this.username,
      this.phone,
      this.website,
      this.street,
      this.city,
      this.suite,
      this.zipCode,
      this.company,
      this.companyCatchPhrase,
      this.companyBs,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail User'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Berikut ini adalah detail User: ",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Nama : $nama',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                Text(
                  'Email : $email',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Username : $username',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Phone : $phone',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Website : $website',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Alamat : \n$street, $suite, $city, $zipCode',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Company : $company',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Alamat : $companyCatchPhrase,',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  companyBs,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
