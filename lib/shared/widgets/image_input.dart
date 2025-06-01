import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ImageInput extends StatefulWidget {
  final String? initialUrl;
  final Function(String) onUrlChanged;

  const ImageInput({
    super.key,
    this.initialUrl,
    required this.onUrlChanged,
  });

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> with AutomaticKeepAliveClientMixin {
  String? uploadedImageUrl;

  @override
  void initState() {
    super.initState();
    uploadedImageUrl = widget.initialUrl;
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory(); // Get local storage directory
      final fileName = DateTime.now().millisecondsSinceEpoch.toString(); // Unique file name
      final savedImage = await File(pickedFile.path).copy('${appDir.path}/$fileName.jpg'); // Save image locally

      setState(() {
        uploadedImageUrl = savedImage.path; // Use local path as image URL
      });

      widget.onUrlChanged(savedImage.path); // Pass the local path to the callback
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Image',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        if (uploadedImageUrl != null)
          Column(
            children: [
              Image.file(
                File(uploadedImageUrl!),
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.broken_image,
                  size: 150,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 8),
            ],
          )
        else
          Container(
            height: 150,
            width: double.infinity,
            color: Colors.grey[200],
            child: const Icon(
              Icons.image,
              size: 100,
              color: Colors.grey,
            ),
          ),
        const SizedBox(height: 8),
        ElevatedButton.icon(
          onPressed: _pickImage,
          icon: const Icon(Icons.upload),
          label: const Text('Upload Image'),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}