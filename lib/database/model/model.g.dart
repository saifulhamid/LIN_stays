// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LINModelAdapter extends TypeAdapter<LINModel> {
  @override
  final int typeId = 0;

  @override
  LINModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LINModel(
      name: fields[0] as String,
      type: fields[1] as String,
      noOfRooms: fields[2] as int,
      maximumGuest: fields[3] as int,
      price: fields[4] as int,
      cleaningFee: fields[5] as int,
      receptionService: fields[6] as String,
      miscellaneous: (fields[7] as List).cast<dynamic>(),
      rules: (fields[8] as List).cast<dynamic>(),
      id: fields[9] as int?,
      image: fields[10] as String,
      place: fields[11] as String,
      isFavorite: fields[12] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, LINModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.noOfRooms)
      ..writeByte(3)
      ..write(obj.maximumGuest)
      ..writeByte(4)
      ..write(obj.price)
      ..writeByte(5)
      ..write(obj.cleaningFee)
      ..writeByte(6)
      ..write(obj.receptionService)
      ..writeByte(7)
      ..write(obj.miscellaneous)
      ..writeByte(8)
      ..write(obj.rules)
      ..writeByte(9)
      ..write(obj.id)
      ..writeByte(10)
      ..write(obj.image)
      ..writeByte(11)
      ..write(obj.place)
      ..writeByte(12)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LINModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class BookAndCancelAdapter extends TypeAdapter<BookAndCancel> {
  @override
  final int typeId = 1;

  @override
  BookAndCancel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookAndCancel(
      id: fields[0] as int?,
      image: fields[1] as String,
      name: fields[2] as String,
      type: fields[3] as String,
      place: fields[4] as String,
      noOfRooms: fields[5] as int,
      maximumGuests: fields[6] as int,
      price: fields[7] as int,
      cleaningFee: fields[8] as int,
      startDay: fields[9] as int,
      startMonth: fields[10] as int,
      startYear: fields[11] as int,
      endDay: fields[12] as int,
      endMonth: fields[13] as int,
      endYear: fields[14] as int,
      daysRange: fields[15] as int,
    );
  }

  @override
  void write(BinaryWriter writer, BookAndCancel obj) {
    writer
      ..writeByte(16)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.image)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.place)
      ..writeByte(5)
      ..write(obj.noOfRooms)
      ..writeByte(6)
      ..write(obj.maximumGuests)
      ..writeByte(7)
      ..write(obj.price)
      ..writeByte(8)
      ..write(obj.cleaningFee)
      ..writeByte(9)
      ..write(obj.startDay)
      ..writeByte(10)
      ..write(obj.startMonth)
      ..writeByte(11)
      ..write(obj.startYear)
      ..writeByte(12)
      ..write(obj.endDay)
      ..writeByte(13)
      ..write(obj.endMonth)
      ..writeByte(14)
      ..write(obj.endYear)
      ..writeByte(15)
      ..write(obj.daysRange);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAndCancelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
