import 'package:hive/hive.dart';

part 'jadwal.g.dart';

@HiveType(typeId: 0)
class MyModel extends HiveObject {
  @HiveField(0)
  late String tanggal;

  @HiveField(1)
  late String nama;

  @HiveField(2)
  late String keterangan;

  MyModel(
      {required this.tanggal, required this.nama, required this.keterangan});
}
