// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AudioAdapter extends TypeAdapter<Audio> {
  @override
  final int typeId = 1;

  @override
  Audio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Audio(
      id: fields[0] as String?,
      artist: fields[3] as String,
      duration: fields[4] as String,
      path: fields[2] as String,
      title: fields[1] as String,
      thumbnail: fields[5] as String,
      favorite: fields[6] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Audio obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.artist)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.thumbnail)
      ..writeByte(6)
      ..write(obj.favorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AudioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
