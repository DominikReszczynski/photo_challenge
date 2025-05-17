import 'package:cas_house/api_service.dart';
import 'package:flutter/material.dart';

class RemoteImageList extends StatelessWidget {
  final List<String> filenames;

  const RemoteImageList({super.key, required this.filenames});
  final String _urlPrefix = ApiService.baseUrl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: filenames.length,
        itemBuilder: (context, index) {
          final imageUrl = '$_urlPrefix/uploads/${filenames[index]}';

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.network(
              imageUrl,
              width: 180,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.broken_image, size: 100);
              },
            ),
          );
        },
      ),
    );
  }
}
