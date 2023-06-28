// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tanamanku/home.dart';
import 'package:tanamanku/jadwal.dart';
import 'package:tanamanku/main.dart';
import 'package:tanamanku/notifikasi.dart';

class notifikasi extends StatefulWidget {
  const notifikasi({Key? key}) : super(key: key);

  @override
  State<notifikasi> createState() => _notifikasiState();
}

class _notifikasiState extends State<notifikasi> {
  List<dynamic> storedList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHive();
  }

  getHive() async {
    DateTime currentDate = DateTime.now();
    box = await Hive.box('jadwal');
    if (box!.get('tanamanListKey') == null) {
      setState(() {
        storedList = [];
      });
    } else {
      setState(() {
        storedList = box!.get('tanamanListKey') as List<dynamic>;
        storedList = storedList.where((item) {
          return DateTime.parse(item.tanggal).isBefore(currentDate) ||
              DateTime.parse(item.tanggal).isAtSameMomentAs(currentDate);
        }).toList();
      });
    }
    print(storedList);
  }

  cekHariIni(data) {
    DateTime currentDate = DateTime.now();
    DateTime tomorrowDate = DateTime.now().add(Duration(days: 1));
    data = DateTime.parse(data);

    DateTime dateToCheck = data; // Tanggal yang ingin Anda periksa

    if (dateToCheck.year == currentDate.year &&
        dateToCheck.month == currentDate.month &&
        dateToCheck.day == currentDate.day) {
      print('1');
      return '1';
    } else if (dateToCheck.year == tomorrowDate.year &&
        dateToCheck.month == tomorrowDate.month &&
        dateToCheck.day == tomorrowDate.day) {
      print('2');
      return '2';
    } else {
      print('3');
      return '3';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color.fromARGB(
              255, 0, 0, 0), // Ganti dengan warna yang Anda inginkan
        ),
        // automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: 70,
        title: Row(
          children: [
            SizedBox(width: 170),
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
          ],
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight * 1,
          width: MediaQuery.of(context).size.width,

// padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 30),
              const Text(
                "Notifikasi",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
              ),
              Container(
                child: storedList == null
                    ? Container()
                    : ListView.builder(
                      reverse: true,
                        shrinkWrap: true,
                        itemCount: storedList.length,
                        itemBuilder: (BuildContext context, int index) {
                          
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                width: 1.5,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                            width: screenWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                    child:
                                        cekHariIni(storedList[index].tanggal) ==
                                                '1'
                                            ? Text(
                                                "Hari ini saatnya ${storedList[index].keterangan} ${storedList[index].nama}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              )
                                            : cekHariIni(storedList[index]
                                                        .tanggal) ==
                                                    '2'
                                                ? Text(
                                                    "Besok saatnya ${storedList[index].keterangan} ${storedList[index].nama}",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  )
                                                : Text(
                                                    "Waktu ${storedList[index].keterangan} ${storedList[index].nama} sudah terlewat",
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                  )),
                                Icon(
                                  Icons.notifications,
                                  size: 50,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
