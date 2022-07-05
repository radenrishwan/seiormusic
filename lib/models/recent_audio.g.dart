// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_audio.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecentAudioAdapter extends TypeAdapter<RecentAudio> {
  @override
  final int typeId = 3;

  @override
  RecentAudio read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentAudio(
      id: fields[0] as String?,
      artist: fields[3] as String,
      duration: fields[4] as String,
      path: fields[2] as String,
      title: fields[1] as String,
      thumbnail: fields[5] as String,
      favorite: fields[6] as bool,
      createdAt: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecentAudio obj) {
    writer
      ..writeByte(8)
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
      ..write(obj.favorite)
      ..writeByte(7)
      ..write(obj.createdAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentAudioAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
