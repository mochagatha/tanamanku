// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jadwal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MyModelAdapter extends TypeAdapter<MyModel> {
  @override
  final int typeId = 0;

  @override
  MyModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MyModel(
      tanggal: fields[0] as String,
      nama: fields[1] as String,
      keterangan: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, MyModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.tanggal)
      ..writeByte(1)
      ..write(obj.nama)
      ..writeByte(2)
      ..write(obj.keterangan);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
