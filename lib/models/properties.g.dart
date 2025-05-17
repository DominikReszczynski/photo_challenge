// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Property _$PropertyFromJson(Map<String, dynamic> json) => Property(
      id: json['_id'] as String?,
      ownerId: json['ownerId'] as String,
      name: json['name'] as String,
      location: json['location'] as String,
      size: (json['size'] as num).toDouble(),
      rooms: (json['rooms'] as num).toInt(),
      floor: (json['floor'] as num).toInt(),
      features: (json['features'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String,
      tenantId: json['tenantId'] as String?,
      rentAmount: (json['rentAmount'] as num).toDouble(),
      depositAmount: (json['depositAmount'] as num).toDouble(),
      paymentCycle: json['paymentCycle'] as String,
      rentalStart: json['rentalStart'] as String?,
      rentalEnd: json['rentalEnd'] as String?,
      imageFilenames: (json['imageFilenames'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      rentalContractFilename: json['rentalContractFilename'] as String?,
      notes: json['notes'] as String?,
      mainImage: json['mainImage'] as String?,
      pin: json['pin'] as String?,
      createdAt: Property._fromJsonDate(json['createdAt']),
      updatedAt: Property._fromJsonDate(json['updatedAt']),
    );

Map<String, dynamic> _$PropertyToJson(Property instance) => <String, dynamic>{
      '_id': instance.id,
      'ownerId': instance.ownerId,
      'name': instance.name,
      'location': instance.location,
      'size': instance.size,
      'rooms': instance.rooms,
      'floor': instance.floor,
      'features': instance.features,
      'status': instance.status,
      'tenantId': instance.tenantId,
      'rentAmount': instance.rentAmount,
      'depositAmount': instance.depositAmount,
      'paymentCycle': instance.paymentCycle,
      'rentalStart': instance.rentalStart,
      'rentalEnd': instance.rentalEnd,
      'imageFilenames': instance.imageFilenames,
      'rentalContractFilename': instance.rentalContractFilename,
      'notes': instance.notes,
      'mainImage': instance.mainImage,
      'pin': instance.pin,
      'createdAt': Property._toJsonDate(instance.createdAt),
      'updatedAt': Property._toJsonDate(instance.updatedAt),
    };
