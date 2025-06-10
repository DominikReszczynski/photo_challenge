import 'package:cas_house/api_service.dart';
import 'package:cas_house/main_global.dart';
import 'package:cas_house/providers/image_provider.dart';
import 'package:cas_house/widgets/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

import '../../models/image_model.dart';
import '../../services/image_services.dart';

class UserImagesMain extends StatefulWidget {

  const UserImagesMain({
    super.key,
  });

  @override
  State<UserImagesMain> createState() => _UserImagesMainState();
}

class _UserImagesMainState extends State<UserImagesMain> {
  // late Future<List<ImageModel>> futureImages;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // futureImages = widget.imageService.getUserImages(loggedUser!.username);
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final provider = Provider.of<ImagesProvider>(context, listen: false);

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
    await Provider.of<ImagesProvider>(context, listen: false).refreshImages();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
      child: SafeArea(
        child: Consumer<ImagesProvider>(
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
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Uploaded: ${image.uploadedAt}",
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
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

// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//     appBar: AppBar(title: const Text('My Uploaded Images')),
//     body: FutureBuilder<List<ImageModel>>(
//       future: futureImages,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//
//         final images = snapshot.data!;
//         if (images.isEmpty) {
//           return const Center(child: Text("No images found."));
//         }
//
//         return ListView.builder(
//           itemCount: images.length,
//           itemBuilder: (context, index) {
//             final image = images[index];
//             return Card(
//               margin: const EdgeInsets.all(10),
//               child: Column(
//                 children: [
//                   CachedNetworkImage(
//                     imageUrl: '${widget.imageService.baseUrl}/uploads/${image.filename}',
//                     placeholder: (context, url) => const CircularProgressIndicator(),
//                     errorWidget: (context, url, error) => const Icon(Icons.error),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "Uploaded: ${image.uploadedAt}",
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         );
//       },
//     ),
//   );
// }
}
