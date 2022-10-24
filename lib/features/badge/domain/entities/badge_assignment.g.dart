// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge_assignment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BadgeAssignmentAdapter extends TypeAdapter<BadgeAssignment> {
  @override
  final int typeId = 2;

  @override
  BadgeAssignment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BadgeAssignment(
      allocator: fields[0] as String,
      holder: fields[1] as String,
      badge: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BadgeAssignment obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.allocator)
      ..writeByte(1)
      ..write(obj.holder)
      ..writeByte(2)
      ..write(obj.badge);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BadgeAssignmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
