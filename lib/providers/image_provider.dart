import 'package:cas_house/main_global.dart';
import 'package:cas_house/models/image_model.dart';
import 'package:flutter/material.dart';
import '../services/image_services.dart';

class ImagesProvider with ChangeNotifier {
  final ImageServices imageService;
  final String userId = loggedUser!.username;

  List<ImageModel> _images = [];
  int _page = 1;
  final int _limit = 10;
  bool _isLoading = false;
  bool _hasMore = true;

  List<ImageModel> get images => _images;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  ImagesProvider({required this.imageService}) {
    fetchImages(reset: true);
  }

  Future<void> fetchImages({bool reset = false}) async {
    print("fetching Images List");
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    if (reset) {
      _page = 1;
      _images = [];
      _hasMore = true;
    }

    try {
      final fetched = await imageService.getUserImages(userId);
      if (fetched.length < _limit) _hasMore = false;

      _images.addAll(fetched);
      _page++;
    } catch (e) {
      _hasMore = false;
      debugPrint('Error fetching images: $e');
    }

    _isLoading = false;
    notifyListeners();

    print("fetching ended: imasges size = ${_images.length}");
  }

  Future<void> refreshImages() async {
    await fetchImages(reset: true);
  }
}
