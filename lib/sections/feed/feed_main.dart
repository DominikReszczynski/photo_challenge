import 'package:cas_house/api_service.dart';
import 'package:cas_house/main_global.dart';
import 'package:cas_house/providers/image_provider.dart';
import 'package:cas_house/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../models/image_model.dart';
import '../../providers/feed_provider.dart';
import '../../services/image_services.dart';
import '../../widgets/info_box.dart';

class FeedMain extends StatefulWidget {

  const FeedMain({
    super.key,
  });

  @override
  State<FeedMain> createState() => _FeedMainState();
}

class _FeedMainState extends State<FeedMain> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final provider = Provider.of<FeedProvider>(context, listen: false);

      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200 &&
          provider.hasMore &&
          !provider.isLoading) {
        provider.fetchImages();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _refresh() async {
    await Provider.of<FeedProvider>(context, listen: false).refreshImages();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: SafeArea(
        child: Consumer<FeedProvider>(
          builder: (context, provider, child) {
            final images = provider.images;
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: images.length + (provider.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == images.length) {
                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  final image = images[index];
                  return Card(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        CachedNetworkImage(
                          imageUrl: '${ApiService.baseUrl}/images/file/${image.fileName}',
                          placeholder: (context, url) => const CircularProgressIndicator(),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width * 0.8,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InfoBox(
                                icon: Icons.person,
                                label: image.userName ?? "unknown",
                                onTap: null,
                              ),
                              InfoBox(
                                icon: Icons.favorite,
                                label: '${image.likes}',
                                onTap: () {
                                  Provider.of<FeedProvider>(context, listen: false)
                                      .toggleLike(image);
                                },
                              ),
                              InfoBox(
                                icon: Icons.comment,
                                label: '${image.comments.length}',
                                onTap: () {
                                  _showCommentsDialog(context, image);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  void _showCommentsDialog(BuildContext context, ImageModel image) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Comments for ${image.fileName}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...image.comments.map((comment) => ListTile(title: Text(comment.content))),
            ],
          ),
        );
      },
    );
  }
}
