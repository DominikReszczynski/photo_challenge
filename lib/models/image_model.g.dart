// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageModel _$ImageModelFromJson(Map<String, dynamic> json) => ImageModel(
      challengeId: json['challengeId'] as String? ?? '',
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              [],
      fileName: json['fileName'] as String,
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      likedBy: (json['likedBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      comments: (json['comments'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      uploadedAt: json['uploadedAt'] as String,
      userName: json['userName'] as String,
    );

Map<String, dynamic> _$ImageModelToJson(ImageModel instance) =>
    <String, dynamic>{
      'challengeId': instance.challengeId,
      'tags': instance.tags,
      'fileName': instance.fileName,
      'likes': instance.likes,
      'likedBy': instance.likedBy,
      'comments': instance.comments.map((e) => e.toJson()).toList(),
      'uploadedAt': instance.uploadedAt,
      'userName': instance.userName,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      content: json['content'] as String,
      userName: json['userName'] as String,
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'content': instance.content,
      'userName': instance.userName,
      'createdAt': instance.createdAt,
    };
