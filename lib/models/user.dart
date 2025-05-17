import 'dart:core';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  @JsonKey(name: '_id')
  String id;
  String email;
  String username;
  String password;

  User({
    required this.id,
    required this.email,
    required this.username,
    required this.password,
  });

  /// Factory constructor for JSON serialization
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Converts the object to JSON
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Factory method for creating an instance from a Map
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'],
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      password: map['password'] ?? '',
    );
  }
}
