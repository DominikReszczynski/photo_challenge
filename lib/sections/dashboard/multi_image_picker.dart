import 'package:cas_house/api_service.dart';
import 'package:cas_house/main_global.dart';
import 'package:cas_house/models/challenge.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'challenge_picker_widget.dart';

class MultiImagePickerExample extends StatefulWidget {
  const MultiImagePickerExample({super.key});

  @override
  MultiImagePickerExampleState createState() => MultiImagePickerExampleState();
}

class MultiImagePickerExampleState extends State<MultiImagePickerExample> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _images = [];
  Challenge? _challenge;

  Future<void> _pickImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();

    setState(() {
      _images = selectedImages;
    });
  }

  Future<void> _uploadImages() async {
    for (var image in _images) {
      const String urlPrefix = ApiService.baseUrl;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$urlPrefix/upload/images'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('images', image.path));
      request.fields['username'] = loggedUser!.username;
      request.fields['challengeId'] = _challenge!.id;

      var response = await request.send();

      if (response.statusCode == 200) {
        print("Upload ok");
        setState(() {
          _images = [];
          _challenge = null;
        });
      } else {
        print("Upload fail: ${response.statusCode}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _pickImages,
          child: const Text("Wybierz zdjęcia"),
        ),
        ChallengePickerButton(onChallengeSelected: (challengeSelected) {
          print("Selected challenge: ${challengeSelected.title}");
          setState(() {
            _challenge = challengeSelected;
          });
        },
        ),
        ElevatedButton(
          onPressed: _images.isNotEmpty && null !=_challenge ? _uploadImages : null,
          child: const Text("Wyślij zdjęcia"),
        ),
        _images.isNotEmpty
            ? SizedBox(
                height: 200,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              File(_images[index].path),
                              height: 180,
                              width: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.close,
                                    color: Colors.white, size: 20),
                                onPressed: () {
                                  setState(() {
                                    _images.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
