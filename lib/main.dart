import 'package:flutter/material.dart';
import 'package:tanamanku/coba.dart';
import 'package:tanamanku/home.dart';
import 'package:tanamanku/jadwal.dart';
import 'package:tanamanku/model/jadwal.dart';
import 'package:tanamanku/notifikasi.dart';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:timezone/data/latest.dart' as tz;

Box? box;

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  // await Hive.deleteBoxFromDisk('jadwal');
  // atau Hive.init(Directory);
  Hive.registerAdapter(MyModelAdapter());
  //mengambil database
  box = await Hive.openBox('jadwal');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: mainScreen(),
    );
  }
}

class mainScreen extends StatefulWidget {
  @override
  State<mainScreen> createState() => _screenState();
}

class _screenState extends State<mainScreen> {
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Widget> page = <Widget>[home(), jadwal(), notifikasi()];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: page.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.white, // Warna item yang dipilih
        unselectedItemColor:
            Color.fromARGB(255, 77, 75, 75), // Warna item yang tidak dipilih
        backgroundColor: Color.fromARGB(255, 58, 177, 62),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Jadwal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifikasi',
          ),
        ],
      ),
    );
  }
}
