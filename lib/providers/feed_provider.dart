import 'package:cas_house/main_global.dart';
import 'package:cas_house/models/image_model.dart';
import 'package:flutter/material.dart';
import '../services/image_services.dart';

class FeedProvider with ChangeNotifier {
  final ImageServices imageService;

  List<ImageModel> _feedImages = [];
  int _page = 1;
  final int _limit = 10;
  bool _isLoading = false;
  bool _hasMore = true;

  List<ImageModel> get images => _feedImages;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;

  FeedProvider({required this.imageService}) {
    fetchImages(reset: true);
  }

  Future<void> fetchImages({bool reset = false}) async {
    if (_isLoading) return;

    _isLoading = true;
    notifyListeners();

    if (reset) {
      _page = 1;
      _feedImages = [];
      _hasMore = true;
    }

    try {
      final fetched = await imageService.getFeed(_page, _limit);
      if (fetched.length < _limit) _hasMore = false;

      _feedImages.addAll(fetched);
      _page++;
    } catch (e) {
      _hasMore = false;
      debugPrint('Error fetching images: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshImages() async {
    await fetchImages(reset: true);
  }

  void toggleLike(ImageModel image) async {
    final username = loggedUser!.username;
    final alreadyLiked = image.likedBy.contains(username);

    if (alreadyLiked) {
      image.likedBy.remove(username);
      image.likes--;
      try {
        await imageService.unlike(image.filename);
      } catch (e) {
        print('Error toggling like: $e');
      }
    } else {
      image.likedBy.add(username);
      image.likes++;
      try {
        await imageService.like(image.filename);
      } catch (e) {
        print('Error toggling like: $e');
      }
    }
    notifyListeners();
  }
}
