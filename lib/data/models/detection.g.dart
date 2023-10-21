// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detection.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DetectionAdapter extends TypeAdapter<Detection> {
  @override
  final int typeId = 1;

  @override
  Detection read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Detection(
      text: fields[0] as String?,
      language: fields[1] as String?,
      isReliable: fields[2] as bool?,
      confidence: fields[3] as double?,
    );
  }

  @override
  void write(BinaryWriter writer, Detection obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.language)
      ..writeByte(2)
      ..write(obj.isReliable)
      ..writeByte(3)
      ..write(obj.confidence);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetectionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
