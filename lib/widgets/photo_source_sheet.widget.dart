import 'package:flutter/material.dart';

class PhotoSourceSheet extends StatelessWidget {
  final VoidCallback onCamera;
  final VoidCallback onGallery;

  const PhotoSourceSheet({
    super.key,
    required this.onCamera,
    required this.onGallery,
  });

  @override
  Widget build(BuildContext context) {
    const iconColor = Color(0xFF6D776F);

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Barra superior
            Container(
              width: 45,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _PhotoOption(
                  icon: Icons.photo_camera_rounded,
                  label: "Câmera",
                  iconColor: iconColor,
                  onTap: onCamera,
                ),
                _PhotoOption(
                  icon: Icons.photo_library_rounded,
                  label: "Galeria",
                  iconColor: iconColor,
                  onTap: onGallery,
                ),
              ],
            ),

            const SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}

class _PhotoOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;

  const _PhotoOption({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).textTheme.bodyMedium!.copyWith(
      color: Colors.black87,
      fontWeight: FontWeight.w500,
    );

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.15),
            ),
            child: Icon(icon, size: 32, color: iconColor),
          ),
          const SizedBox(height: 8),
          Text(label, style: style),
        ],
      ),
    );
  }
}
