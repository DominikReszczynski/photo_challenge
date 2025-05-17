import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

part 'properties.g.dart';

@JsonSerializable(explicitToJson: true)
class Property {
  @JsonKey(name: '_id')
  String? id;

  String ownerId;
  String name;
  String location;
  double size;
  int rooms;
  int floor;
  List<String>? features; // np. balkon, piwnica itd.

  String status; // np. "wynajęte", "wolne"
  String? tenantId;
  double rentAmount;
  double depositAmount;
  String paymentCycle; // np. "miesięczna"
  String? rentalStart;
  String? rentalEnd;

  List<String>? imageFilenames;
  String? rentalContractFilename;
  String? notes;
  String? mainImage;
  String? pin;

  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  DateTime? createdAt;

  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  DateTime? updatedAt;

  Property({
    this.id,
    required this.ownerId,
    required this.name,
    required this.location,
    required this.size,
    required this.rooms,
    required this.floor,
    this.features,
    required this.status,
    this.tenantId,
    required this.rentAmount,
    required this.depositAmount,
    required this.paymentCycle,
    this.rentalStart,
    this.rentalEnd,
    this.imageFilenames,
    this.rentalContractFilename,
    this.notes,
    this.mainImage,
    this.pin,
    this.createdAt,
    this.updatedAt,
  });

  factory Property.fromJson(Map<String, dynamic> json) =>
      _$PropertyFromJson(json);
  Map<String, dynamic> toJson() => _$PropertyToJson(this);

  static DateTime? _fromJsonDate(dynamic date) =>
      date == null ? null : DateTime.parse(date.toString());
  static String? _toJsonDate(DateTime? date) => date?.toIso8601String();
}
