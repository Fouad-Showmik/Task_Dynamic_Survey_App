import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:survey/data/models/field_model.dart';

class ImageFieldWidget extends StatefulWidget {
  final FieldModel field;

  const ImageFieldWidget({super.key, required this.field});

  @override
  State<ImageFieldWidget> createState() => _ImageFieldWidgetState();
}

class _ImageFieldWidgetState extends State<ImageFieldWidget> {
  String? imagePath;

  Future<bool> requestPermissions(ImageSource source) async {
    if (source == ImageSource.camera) {
      return await Permission.camera.request().isGranted;
    } else {
      return await Permission.photos.request().isGranted;
    }
  }

  Future<void> pickImage() async {
    final source = await showDialog<ImageSource>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Choose Image Source'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, ImageSource.camera),
                child: const Text('Camera'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, ImageSource.gallery),
                child: const Text('Gallery'),
              ),
            ],
          ),
    );

    if (source == null) return;

    final granted = await requestPermissions(source);
    if (!granted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Permission denied')));
      return;
    }

    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imagePath = pickedFile.path;
        widget.field.resultValue = imagePath;
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('No image selected')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (imagePath != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(File(imagePath!), height: 150, fit: BoxFit.cover),
          ),
        ElevatedButton(
          onPressed: pickImage,
          child: Text(widget.field.properties.label ?? 'Upload Photo'),
        ),
      ],
    );
  }
}
