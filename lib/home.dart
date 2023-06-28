// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:tanamanku/jadwal.dart';
import 'package:tanamanku/notifikasi.dart';
// import 'package:tanamanku/dimension.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController _searchController = TextEditingController();
  String _searchText = '';

  void _onSearchTextChanged(String value) {
    setState(() {
      _searchText = value;
    });
  }

  void _onSearchButtonPressed() {
    // Lakukan aksi pencarian sesuai dengan _searchText
    // Misalnya, tampilkan hasil pencarian atau lakukan pemfilteran data
    print('Pencarian: $_searchText');
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        title: Row(
          children: [
            const SizedBox(width: 110),
            Transform(
              transform: Matrix4.translationValues(
                0, // Geser ke kanan sebesar 50.0
                5, // Tidak ada pergeseran vertikal
                0.0, // Tidak ada pergeseran kedalaman
              ),
              child: Image.asset(
                'assets/logoTanaman.png',
                width: 150.0,
                height: 60.0,
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(width: 75),
            // Transform(
            //   transform: Matrix4.translationValues(
            //     15, // Geser ke kanan sebesar 50.0
            //     0.0, // Tidak ada pergeseran vertikal
            //     0.0, // Tidak ada pergeseran kedalaman
            //   ),
            //   child: Image.asset(
            //     'assets/Vector.png',
            //     width: 35.0,
            //     height: 35.0,
            //     fit: BoxFit.fill,
            //   ),
            // )
          ],
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: 500,
                height: 80.0,
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    // Transform(
                    //   transform: Matrix4.translationValues(
                    //     125, // Geser ke kanan sebesar 50.0
                    //     0, // Tidak ada pergeseran vertikal
                    //     0.0, // Tidak ada pergeseran kedalaman
                    //   ),
                    //   child: Container(
                    //     width: 150,
                    //     height: 30,
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.circular(16),
                    //       border: Border.all(
                    //         width: 1.5,
                    //         color: Color.fromARGB(255, 0, 0, 0),
                    //       ),
                    //     ),
                    //     child: Row(
                    //       children: [
                    //         Expanded(
                    //             child: Transform(
                    //           transform: Matrix4.translationValues(
                    //             10, // Geser ke kanan sebesar 50.0
                    //             5, // Tidak ada pergeseran vertikal
                    //             0.0, // Tidak ada pergeseran kedalaman
                    //           ),
                    //           child: const TextField(
                    //             decoration: InputDecoration(
                    //               hintText: 'Search',
                    //               border: InputBorder.none,
                    //             ),
                    //           ),
                    //         )),
                    //         Icon(Icons.search),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Container(
                        child: Transform(
                      transform: Matrix4.translationValues(
                        -130, // Geser ke kanan sebesar 50.0
                        20, // Tidak ada pergeseran vertikal
                        0.0, // Tidak ada pergeseran kedalaman
                      ),
                      child: const Text(
                        "Pusat Informasi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ))
                  ],
                ),
              ),
              Container(
                height: 250,
                decoration: const BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      16.0,
                    ),
                  ),
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(
                          8.0), // Padding antara setiap gambar
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/Padi.png",
                            width: 250,
                            height: 150.0,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Padi",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text("Padi adalah tanaman pangan"),
                          const Text("yang menjadi sumber utama"),
                          const Text("beras di banyak negara")
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.all(8.0), // Padding antara setiap gambar
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/jagung.png",
                            width: 250,
                            height: 150.0,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Jagung",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text("Jagung adalah tanaman sereal yang"),
                          const Text("menghasilkan biji-bijian yang digunakan"),
                          const Text("sebagai makanan manusia, dll"),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.all(8.0), // Padding antara setiap gambar
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/kacang.png",
                            width: 250,
                            height: 150.0,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 5),
                          const Text(
                            "Kacang Hijau",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text("Kacang hijau adalah jenis kacang-"),
                          const Text("kacangan yang biasa digunakan"),
                          const Text("sebagai bahan makanan")
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              SizedBox(
                height: 20,
                child: Transform(
                  transform: Matrix4.translationValues(
                    -95, // Geser ke kanan sebesar 50.0
                    0.0, // Tidak ada pergeseran vertikal
                    0.0, // Tidak ada pergeseran kedalaman
                  ),
                  child: const Text(
                    "Tips And Trick Menanam",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                height: 400,
                decoration: const BoxDecoration(
                  // color: Colors.blue,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      16.0,
                    ),
                  ),
                ),
                child: ListView(
                  physics: NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.all(8.0), // Padding antara setiap gambar
                      child: Container(
                        width: 400,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/Padi.png",
                              width: 150,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 100.0,
                              width: 222.5,
                              decoration: const BoxDecoration(
                                // color: Colors.orange,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                              child: const SingleChildScrollView(
                                child: Text(
                                    "Pilih lahan yang tergenang air atau memiliki sistem irigasi yang baik, tanam bibit padi pada kedalaman 2-3 cm dengan jarak tanam sekitar 20-30 cm, pastikan lahan selalu tergenang air dengan kedalaman sekitar 5-10 cm, dan berikan pupuk sesuai kebutuhan tanaman padi."),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.all(8.0), // Padding antara setiap gambar
                      child: Container(
                        width: 400,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/jagung.png",
                              width: 150,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 10),
                            Container(
                              height: 100.0,
                              width: 222.5,
                              decoration: const BoxDecoration(
                                // color: Colors.orange,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                              child: const SingleChildScrollView(
                                child: Text(
                                    "Pilih lahan yang terkena sinar matahari penuh, tanam benih jagung pada kedalaman 5-7 cm dengan jarak tanam sekitar 25-30 cm, dan berikan air secara teratur untuk menjaga kelembapan tanah."),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.all(8.0), // Padding antara setiap gambar
                      child: Container(
                        width: 400,
                        height: 120,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1.5,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 5,
                            ),
                            Image.asset(
                              "assets/kacang.png",
                              width: 150,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                            const SizedBox(width: 10),
                            Container(
                              height: 100.0,
                              width: 222.5,
                              decoration: const BoxDecoration(
                                // color: Colors.orange,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                    16.0,
                                  ),
                                ),
                              ),
                              child: const SingleChildScrollView(
                                child: Text(
                                    "Pilih lahan yang terkena sinar matahari penuh, tanam benih kacang hijau pada kedalaman 2-3 cm dengan jarak tanam sekitar 10-15 cm, pastikan lahan terjaga kelembapannya dengan penyiraman yang cukup, dan berikan pupuk organik untuk meningkatkan pertumbuhan tanaman kacang hijau."),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
