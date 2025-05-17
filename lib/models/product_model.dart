import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ProductModel {
  @JsonKey(name: '_id')
  final String? id;
  final String name;
  final String? producent;
  final String? shop;
  final double? amount;
  final String? unit;
  final double? price;
  final String? currency;
  final String category;
  final String priority;
  final DateTime date;
  final bool isBuy;

  ProductModel({
    this.id,
    required this.name,
    this.producent,
    this.shop,
    this.amount,
    this.unit,
    this.price,
    this.currency,
    required this.category,
    required this.priority,
    required this.date,
    this.isBuy = false,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  /// Dodanie metody `copyWith`
  ProductModel copyWith({
    String? id,
    String? name,
    String? producent,
    String? shop,
    double? amount,
    String? unit,
    double? price,
    String? currency,
    String? category,
    String? priority,
    DateTime? date,
    bool? isBuy,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      producent: producent ?? this.producent,
      shop: shop ?? this.shop,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      date: date ?? this.date,
      isBuy: isBuy ?? this.isBuy,
    );
  }
}
