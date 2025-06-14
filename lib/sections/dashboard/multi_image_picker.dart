import 'package:cas_house/api_service.dart';
import 'package:cas_house/main_global.dart';
import 'package:cas_house/models/challenge.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
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
  bool _isUploading = false;
  String? _errorMessage;
  String? _successMessage;

  Future<void> _pickImages() async {
    final List<XFile> selectedImages = await _picker.pickMultiImage();

    setState(() {
      _images = selectedImages;
      _errorMessage = null;
      _successMessage = null;
    });
  }

  Future<void> _uploadImages() async {
    setState(() {
      _isUploading = true;
      _errorMessage = null;
      _successMessage = null;
    });
    bool anyFailed = false;
    for (var image in _images) {
      const String urlPrefix = ApiService.baseUrl;
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$urlPrefix/upload/images'),
      );
      request.files
          .add(await http.MultipartFile.fromPath('images', image.path));
      request.fields['userName'] = loggedUser!.username;
      request.fields['challengeId'] = _challenge!.id;

      var response = await request.send();

      if (response.statusCode == 200) {
        // OK
      } else {
        anyFailed = true;
      }
    }
    setState(() {
      _isUploading = false;
      if (anyFailed) {
        _errorMessage = "Wysyłanie niektórych zdjęć nie powiodło się.";
        _successMessage = null;
      } else {
        _successMessage = "Zdjęcia zostały wysłane!";
        _errorMessage = null;
        _images = [];
        _challenge = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 16,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Dodaj zdjęcia do wyzwania',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF926C20),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _isUploading ? null : _pickImages,
                icon: const Icon(
                  Icons.photo_library,
                  color: Colors.white,
                ),
                label: Text(
                  "Wybierz zdjęcia",
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFF926C20),
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 16),
              ChallengePickerButton(
                onChallengeSelected: (challengeSelected) {
                  setState(() {
                    _challenge = challengeSelected;
                  });
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed:
                    (_images.isNotEmpty && _challenge != null && !_isUploading)
                        ? _uploadImages
                        : null,
                icon: const Icon(
                  Icons.cloud_upload,
                  color: Colors.white,
                ),
                label: _isUploading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text(
                        "Wyślij zdjęcia",
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500, color: Colors.white),
                      ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color(0xFF926C20),
                  elevation: 2,
                ),
              ),
              const SizedBox(height: 16),
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              if (_successMessage != null)
                Text(
                  _successMessage!,
                  style: const TextStyle(color: Colors.green),
                ),
              const SizedBox(height: 16),
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
                                      color:
                                          Colors.black.withValues(alpha: 0.6),
                                      shape: BoxShape.circle,
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.close,
                                          color: Colors.white, size: 20),
                                      onPressed: _isUploading
                                          ? null
                                          : () {
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
          ),
        ),
      ),
    );
  }
}
