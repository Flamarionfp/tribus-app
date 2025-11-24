import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tribus/widgets/button.widget.dart';
import 'package:tribus/widgets/photo_picker.widget.dart';
import 'package:tribus/widgets/select_input.widget.dart';
import 'package:tribus/widgets/text_input.widget.dart';
import 'package:image_picker/image_picker.dart';

class RegisterRecyclableMaterialScreen extends StatefulWidget {
  const RegisterRecyclableMaterialScreen({super.key});

  @override
  State<RegisterRecyclableMaterialScreen> createState() =>
      _RegisterRecyclableMaterialScreenState();
}

class _RegisterRecyclableMaterialScreenState
    extends State<RegisterRecyclableMaterialScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  String? selectedCategory;
  bool _picking = false;
  File? selectedImage;

  Future<void> pickImage() async {
    if (_picking) return;

    _picking = true;

    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        setState(() {
          selectedImage = File(image.path);
        });
      }
    } finally {
      _picking = false;
    }
  }

  void submit() {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) return;

    if (selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Selecione uma foto!")));
      return;
    }

    print("Categoria: $selectedCategory");
    print("Descrição: ${descriptionController.text}");
    print("Imagem: ${selectedImage!.path}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Center(
          child: Text(
            'Cadastrar Material',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PhotoPickerBox(
                    fileImage: selectedImage,
                    imagePath: "assets/recycle.png",
                    title: "Adicionar Foto",
                    onTap: pickImage,
                  )
                  .animate()
                  .fade(duration: 500.ms, curve: Curves.easeOut)
                  .scale(
                    begin: Offset(0.95, 0.95),
                    duration: 500.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(begin: 0.05, duration: 500.ms, curve: Curves.easeOut),

              const SizedBox(height: 40),

              SelectInput(
                    label: "Categoria",
                    value: selectedCategory,
                    options: const ["Madeira", "Metal", "Plástico", "Outro"],
                    validator: (value) =>
                        value == null ? "Selecione uma categoria." : null,
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  )
                  .animate(delay: 150.ms)
                  .fade(duration: 500.ms, curve: Curves.easeOut)
                  .slideY(begin: 0.08, duration: 500.ms, curve: Curves.easeOut),

              const SizedBox(height: 12),

              TextInput(
                    label: "Descrição",
                    controller: descriptionController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe uma descrição.";
                      }
                      return null;
                    },
                  )
                  .animate(delay: 250.ms)
                  .fade(duration: 550.ms, curve: Curves.easeOut)
                  .slideY(begin: 0.08, duration: 550.ms, curve: Curves.easeOut),

              const SizedBox(height: 20),

              Button(title: 'Cadastrar Material', onPressed: submit)
                  .animate(delay: 350.ms)
                  .fade(duration: 500.ms, curve: Curves.easeOut)
                  .slideY(begin: 0.1, duration: 500.ms, curve: Curves.easeOut)
                  .scale(
                    begin: Offset(0.97, 0.97),
                    duration: 350.ms,
                    curve: Curves.easeOut,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
