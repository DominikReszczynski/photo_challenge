import 'dart:convert';
import 'package:cas_house/api_service.dart';
import 'package:http/http.dart' as http;

import '../main_global.dart';
import '../models/image_model.dart';

class ImageServices {
  final String baseUrl = ApiService.baseUrl;

  Future<List<ImageModel>> getUserImages(String userId) async {
    final response = await http.get(Uri.parse('$baseUrl/images/user/$userId'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List images = data['images'];
      return images.map((json) => ImageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<List<ImageModel>> getUserImagesPages(String userId, int page, int limit) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/images/user/$userId?page=$page&limit=$limit',
    ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List images = data['images'];
      return images.map((json) => ImageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<List<ImageModel>> getFeed(int page, int limit) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/images/top-liked?page=$page&limit=$limit',
    ));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List images = data['images'];
      return images.map((json) => ImageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }

  Future<void> like(String imageId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/images/$imageId/like'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userName': loggedUser!.username}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to like');
    }
  }

  Future<void> unlike(String imageId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/images/$imageId/unlike'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userName': loggedUser!.username}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to unlike');
    }
  }
}
