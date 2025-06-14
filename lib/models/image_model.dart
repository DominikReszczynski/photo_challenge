import 'package:cas_house/main_global.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_model.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageModel {
  @JsonKey(defaultValue: "")
  final String challengeId;
  @JsonKey(defaultValue: [])
  final List<String> tags;
  final String fileName;
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
    required this.fileName,
    required this.likes,
    required this.likedBy,
    required this.comments,
    required this.uploadedAt,
    required this.userName,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) => _$ImageModelFromJson(json);

  get isLiked => likedBy.contains(loggedUser!.username);

  Map<String, dynamic> toJson() => _$ImageModelToJson(this);
}

@JsonSerializable()
class Comment {
  final String content;
  final String userName;
  final String createdAt;

  Comment({
    required this.content,
    required this.userName,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}
