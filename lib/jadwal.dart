// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:timezone/timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:tanamanku/home.dart';
import 'package:tanamanku/main.dart';
import 'package:tanamanku/model/jadwal.dart';
import 'package:tanamanku/notifikasi.dart';
import 'package:timezone/timezone.dart' as tz;

class jadwal extends StatefulWidget {
  const jadwal({Key? key}) : super(key: key);

  @override
  State<jadwal> createState() => _jadwalState();
}

double screenHeight = 0;
double screenWidth = 0;

class _jadwalState extends State<jadwal> {
  DateTime selectedDate = DateTime.now();
  List<dynamic> storedList = [];

  final TextEditingController _controllerTanggal = TextEditingController();
  String selectedJadwal = 'Menanam';
  List<String> jadwal = ['Menanam', 'Memanen'];

  String selectedTanaman = 'Padi';
  List<String> tanaman = ['Padi', 'Jagung', 'Kacang Hijau'];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _controllerTanggal.text =
            "${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}";
      });
    }
  }

  getHive() async {
    box = await Hive.openBox('jadwal');
    if (box!.get('tanamanListKey') == null) {
      setState(() {
        storedList = [];
      });
    } else {
      setState(() {
        storedList = box!.get('tanamanListKey') as List<dynamic>;
      });
    }
  }

  convertHari(DateTime date) {
    String? hari;
    if (date.weekday == 1) hari = "Senin";
    if (date.weekday == 2) hari = "Selasa";
    if (date.weekday == 3) hari = "Rabu";
    if (date.weekday == 4) hari = "Kamis";
    if (date.weekday == 5) hari = "Jumat";
    if (date.weekday == 6) hari = "Sabtu";
    if (date.weekday == 7) hari = "Minggu";
    return hari;
  }

  convertBulan(DateTime date) {
    String? bulan;
    if (date.month == 1) bulan = "Januari";
    if (date.month == 2) bulan = "Februari";
    if (date.month == 3) bulan = "Maret";
    if (date.month == 4) bulan = "April";
    if (date.month == 5) bulan = "Mei";
    if (date.month == 6) bulan = "Juni";
    if (date.month == 7) bulan = "Juli";
    if (date.month == 3) bulan = "Agustus";
    if (date.month == 4) bulan = "September";
    if (date.month == 5) bulan = "Oktober";
    if (date.month == 6) bulan = "November";
    if (date.month == 7) bulan = "Desember";
    return bulan;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHive();
    _controllerTanggal.text =
        "${selectedDate.day} - ${selectedDate.month} - ${selectedDate.year}";
    box = Hive.box('jadwal');
  }

  // Inisialisasi FlutterLocalNotificationsPlugin
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // Konfigurasi plugin notifikasi
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Mengatur pengaturan notifikasi
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeating_channel_id',
      'Repeating Channel',
      importance: Importance.max,
      priority: Priority.high,
    );
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

Future<void> _scheduleNotification(
  NotificationDetails details,
  DateTime scheduledDate,
  String keterangan,
) async {
  // Tunggu inisialisasi database zona waktu sebelum menggunakan getLocation
  // await tz.initializeTimeZones();
  final timeZone = tz.getLocation('Asia/Jakarta');
  final tzDateTime = tz.TZDateTime.from(scheduledDate, timeZone);

  // Mengatur jadwal notifikasi
  await flutterLocalNotificationsPlugin.zonedSchedule(
    0, // ID notifikasi
    'Pengingat',
    keterangan,
    tzDateTime.add(const Duration(seconds: 5)),
    details,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    androidAllowWhileIdle: true,
  );
}

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
          height: screenHeight * 0.821,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Text(
                "Perawatan Dan Jadwal Panen",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    height: screenWidth * 0.50,
                    width: screenWidth * 0.45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Pilih Jadwal",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextField(
                          controller: _controllerTanggal,
                          onTap: () {
                            _selectDate(context);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Tanggal',
                            border: InputBorder.none,
                            fillColor: Colors.green,
                          ),
                        ),
                        DropdownButton<String>(
                          value: selectedJadwal,
                          items: jadwal.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedJadwal = newValue!;
                            });
                          },
                        ),
                        DropdownButton<String>(
                          value: selectedTanaman,
                          items: tanaman.map((String option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedTanaman = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: screenWidth * 0.50,
                    width: screenWidth * 0.45,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1.5,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(16.0),
                        bottomRight: Radius.circular(16.0),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          keterangan("Hari", convertHari(selectedDate)),
                          const Divider(
                            height: 10,
                          ),
                          keterangan("Tanggal",
                              "${selectedDate.day}-${selectedDate.month}-${selectedDate.year}"),
                          const Divider(
                            height: 10,
                          ),
                          keterangan("Tanaman", selectedTanaman),
                          const Divider(
                            height: 10,
                          ),
                          keterangan("Jadwal", selectedJadwal),
                          const Divider(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Transform(
                transform: Matrix4.translationValues(
                  screenWidth * 0.299, // Geser ke kanan sebesar 50.0
                  10, // Tidak ada pergeseran vertikal
                  0.0, // Tidak ada pergeseran kedalaman
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Tindakan yang akan dilakukan saat tombol ditekan
                    storedList.add(
                      MyModel(
                        tanggal: selectedDate.toString(),
                        keterangan: selectedJadwal,
                        nama: selectedTanaman,
                      ),
                    );
                    box!.put('tanamanListKey', storedList);
                    _scheduleNotification(
                        platformChannelSpecifics,
                        selectedDate,
                        "Hari ini saatnya $selectedJadwal $selectedTanaman");
                    _scheduleNotification(
                        platformChannelSpecifics,
                        selectedDate.subtract(const Duration(days: 1)),
                        "Besok saatnya $selectedJadwal $selectedTanaman");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(13.0), // Mengatur radius border
                    ),
                  ),
                  child: Text(
                    'Buat Jadwal',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              const Text(
                "Jadwal",
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: screenWidth * 0.5,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                           borderRadius: BorderRadius.all(
                  Radius.circular(
                  16.0,
                  ),
                  ),
                
                ),
                child: storedList == null
                    ? Container()
                    : ListView.builder(
                      // reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: storedList.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.all(
                                8.0), // Padding antara setiap gambar
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                  size: 24.0,
                                ),
                                SizedBox(width: 15),
                                Container(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // SizedBox(height: 20),
                                      Text(
                                        "${convertHari(DateTime.parse(storedList[index].tanggal))}, ${DateTime.parse(storedList[index].tanggal).day} ${convertBulan(DateTime.parse(storedList[index].tanggal))} ${DateTime.parse(storedList[index].tanggal).year}",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "Waktunya untuk ${storedList[index].keterangan} ${storedList[index].nama} pada hari ${convertHari(DateTime.parse(storedList[index].tanggal))}, ${DateTime.parse(storedList[index].tanggal).day} ${convertBulan(DateTime.parse(storedList[index].tanggal))} ${DateTime.parse(storedList[index].tanggal).year}",
                                        style: TextStyle(
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
              ),
                            ElevatedButton(
  onPressed: () {
    setState(() {
      storedList = [];
    });
    box!.delete('tanamanListKey');
  },
  style: ElevatedButton.styleFrom(
    primary: Color.fromARGB(255, 255, 17, 0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(13.0),
    ),
  ),
  child: Text(
    'Hapus',
    style: TextStyle(
      fontSize: 16.0,
    ),
  ),
),
            ],
          ),
        ),
      ),
    );
  }

  Widget keterangan(String head, var date) {
    return Row(
      children: [
        Container(
          width: screenWidth * 0.17,
          child: Text("$head"),
        ),
        Container(
          child: Text("= $date"),
        )
      ],
    );
  }
}
