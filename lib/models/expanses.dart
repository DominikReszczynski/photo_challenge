import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

part 'expanses.g.dart';

@JsonSerializable(explicitToJson: true)
class Expanses {
  @JsonKey(name: '_id')
  String? id;
  String authorId;
  String name;
  String? description;
  double amount;
  String currency;
  String? placeOfPurchase;
  String category;

  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  DateTime? createdAt;

  @JsonKey(fromJson: _fromJsonDate, toJson: _toJsonDate)
  DateTime? updatedAt;

  Expanses({
    this.id,
    required this.authorId,
    required this.name,
    this.description,
    required this.amount,
    required this.currency,
    this.placeOfPurchase,
    required this.category,
    this.createdAt,
    this.updatedAt,
  });

  /// Factory constructor for JSON serialization
  factory Expanses.fromJson(Map<String, dynamic> json) =>
      _$ExpansesFromJson(json);

  /// Converts the object to JSON
  Map<String, dynamic> toJson() => _$ExpansesToJson(this);

  /// Factory method for creating an instance from a Map
  factory Expanses.fromMap(Map<String, dynamic> map) {
    return Expanses(
      id: map['_id'],
      authorId: map['authorId'] ?? '',
      name: map['name'] ?? '',
      description: map['description'],
      amount: (map['amount'] as num).toDouble(),
      currency: map['currency'] ?? '',
      placeOfPurchase: map['placeOfPurchase'],
      category: map['category'] ?? '',
      createdAt: _fromJsonDate(map['createdAt']),
      updatedAt: _fromJsonDate(map['updatedAt']),
    );
  }

  /// Helper methods for parsing DateTime
  static DateTime? _fromJsonDate(dynamic date) {
    if (date == null) return null;
    return DateTime.parse(date.toString());
  }

  static String? _toJsonDate(DateTime? date) {
    return date?.toIso8601String();
  }
}
