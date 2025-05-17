// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      id: json['_id'] as String?,
      name: json['name'] as String,
      producent: json['producent'] as String?,
      shop: json['shop'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      category: json['category'] as String,
      priority: json['priority'] as String,
      date: DateTime.parse(json['date'] as String),
      isBuy: json['isBuy'] as bool? ?? false,
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'producent': instance.producent,
      'shop': instance.shop,
      'amount': instance.amount,
      'unit': instance.unit,
      'price': instance.price,
      'currency': instance.currency,
      'category': instance.category,
      'priority': instance.priority,
      'date': instance.date.toIso8601String(),
      'isBuy': instance.isBuy,
    };
