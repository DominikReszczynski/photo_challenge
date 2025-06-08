import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageModel {
  @JsonKey(defaultValue: "")
  final String challengeId;
  @JsonKey(defaultValue: [])
  final List<String> tags;
  final String filename;
  @JsonKey(defaultValue: 0)
  late int likes;
  @JsonKey(defaultValue: [])
  List<String> likedBy;
  @JsonKey(defaultValue: [])
  final List<Comment> comments;
  final String uploadedAt;
  final String userName;

  ImageModel({
    required this.challengeId,
    required this.tags,
    required this.filename,
    required this.likes,
    required this.likedBy,
    required this.comments,
    required this.uploadedAt,
    required this.userName,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}

@JsonSerializable()
class Comment {
  final String text;
  final String user;
  final String createdAt;

  Comment({
    required this.text,
    required this.user,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
