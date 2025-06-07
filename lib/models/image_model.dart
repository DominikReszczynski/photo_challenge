import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(explicitToJson: true)
class ImageModel {
  final String id;
  final String filename;
  final String userName;
  final String uploadedAt;

  ImageModel({
    required this.id,
    required this.filename,
    required this.userName,
    required this.uploadedAt,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['_id'],
      filename: json['filename'],
      userName: json['userName'],
      uploadedAt: json['uploadedAt'],
    );
  }
}
