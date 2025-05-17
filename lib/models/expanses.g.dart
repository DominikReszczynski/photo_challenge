// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expanses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Expanses _$ExpansesFromJson(Map<String, dynamic> json) => Expanses(
      id: json['_id'] as String?,
      authorId: json['authorId'] as String,
      name: json['name'] as String,
      description: json['description'] as String?,
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String,
      placeOfPurchase: json['placeOfPurchase'] as String?,
      category: json['category'] as String,
      createdAt: Expanses._fromJsonDate(json['createdAt']),
      updatedAt: Expanses._fromJsonDate(json['updatedAt']),
    );

Map<String, dynamic> _$ExpansesToJson(Expanses instance) => <String, dynamic>{
      '_id': instance.id,
      'authorId': instance.authorId,
      'name': instance.name,
      'description': instance.description,
      'amount': instance.amount,
      'currency': instance.currency,
      'placeOfPurchase': instance.placeOfPurchase,
      'category': instance.category,
      'createdAt': Expanses._toJsonDate(instance.createdAt),
      'updatedAt': Expanses._toJsonDate(instance.updatedAt),
    };
