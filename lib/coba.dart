import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tanamanku/main.dart';
import 'package:tanamanku/model/jadwal.dart';

class coba extends StatefulWidget {
  @override
  State<coba> createState() => _cobaState();
}

class _cobaState extends State<coba> {
  late MyModel model;
  late List<dynamic> storedList = [];

  getHive() async {
    box = Hive.box('jadwal');
    print(box!.get('tanamanListKey'));
    storedList = box!.get('tanamanListKey') as List<dynamic>;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHive();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        // child: Text('${model.person[0].nama} + ${model.person[0].nama}'),
        child: ElevatedButton(
          child: Text('AKAKAKAKAK'),
          onPressed: () {
            print(storedList);
            // storedList.add(MyModel(name: 'aka', age: 23));
            storedList.add(
              MyModel(
                tanggal: "selectedDate.toString()",
                keterangan: "selectedJadwal",
                nama: "selectedTanaman",
              ),
            );
            print(storedList);
            box!.put('tanamanListKey', storedList);
          },
        ),
      ),
    );
  }
}
