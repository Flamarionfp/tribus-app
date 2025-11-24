import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class PhotoPickerBox extends StatelessWidget {
  final File? fileImage;
  final String imagePath;
  final String title;
  final VoidCallback? onTap;

  const PhotoPickerBox({
    super.key,
    this.fileImage,
    required this.imagePath,
    this.title = "Adicionar Foto",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 165,
        width: 165,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.7), width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            fileImage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      fileImage!,
                      height: 90,
                      width: 90,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(imagePath, height: 70).animate().rotate(
                    duration: 1.5.seconds,
                    curve: Curves.fastOutSlowIn,
                  ),

            const SizedBox(height: 8),

            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 10),
            const Icon(Icons.photo_camera, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
