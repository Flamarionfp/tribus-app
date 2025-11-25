import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:tribus/widgets/button.widget.dart';
import 'package:tribus/widgets/photo_picker.widget.dart';
import 'package:tribus/widgets/select_input.widget.dart';
import 'package:tribus/widgets/text_input.widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tribus/services/api_service.dart';

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
  final ApiService api = ApiService();

  String? selectedCategory;
  bool _picking = false;
  bool _loadingPrediction = false;
  File? selectedImage;
  List<Map<String, String>> classOptions = [];
  List<String> labels = [];

  @override
  void initState() {
    super.initState();
    loadClasses();
  }

  Future<void> loadClasses() async {
    try {
      final result = await api.fetchClasses();

      setState(() {
        classOptions = result;

        labels = classOptions.map((e) => e["label"]!).toList();

        if (!labels.contains("Outro")) {
          labels.add("Outro");
        }
      });
    } catch (e) {
      debugPrint("Erro ao carregar classes: $e");
    }
  }

  Future<void> predictCategory(File image) async {
    setState(() => _loadingPrediction = true);

    try {
      final json = await api.predictImage(image);

      final predictedId = json["predicted_class"];
      final predictedLabel = json["predicted_class_pt"];

      final exists = classOptions.any((e) => e["id"] == predictedId);

      setState(() {
        selectedCategory = exists ? predictedId : null;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Categoria sugerida: $predictedLabel")),
      );
    } catch (e) {
      debugPrint("Erro na predição: $e");
    }

    setState(() => _loadingPrediction = false);
  }

  Future<void> pickImage() async {
    if (_picking) return;
    _picking = true;

    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        final file = File(image.path);

        setState(() => selectedImage = file);

        await predictCategory(file);
      }
    } finally {
      _picking = false;
    }
  }

  void submit() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;

    if (selectedImage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Selecione uma foto!")));
      return;
    }

    print("Categoria (ID): $selectedCategory");
    print("Descrição: ${descriptionController.text}");
    print("Imagem: ${selectedImage!.path}");
  }

  @override
  Widget build(BuildContext context) {
    final currentLabel = () {
      if (selectedCategory == null) return null;

      final match = classOptions.firstWhere(
        (e) => e["id"] == selectedCategory,
        orElse: () => {"label": "Outro"},
      );

      return match["label"];
    }();

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
                    title: _loadingPrediction
                        ? "Analisando..."
                        : "Adicionar Foto",
                    onTap: pickImage,
                  )
                  .animate()
                  .fade(duration: 500.ms, curve: Curves.easeOut)
                  .scale(
                    begin: const Offset(0.95, 0.95),
                    duration: 500.ms,
                    curve: Curves.easeOut,
                  )
                  .slideY(begin: 0.05, duration: 500.ms, curve: Curves.easeOut),

              const SizedBox(height: 40),

              SelectInput(
                    label: "Categoria",
                    value: currentLabel,
                    options: labels,
                    validator: (value) =>
                        value == null ? "Selecione uma categoria." : null,
                    onChanged: (value) {
                      if (value == "Outro") {
                        setState(() => selectedCategory = null);
                      } else {
                        final match = classOptions.firstWhere(
                          (e) => e["label"] == value,
                        );
                        setState(() => selectedCategory = match["id"]);
                      }
                    },
                  )
                  .animate(delay: 150.ms)
                  .fade(duration: 500.ms)
                  .slideY(begin: 0.08, duration: 500.ms),

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

              Button(title: "Cadastrar Material", onPressed: submit)
                  .animate(delay: 350.ms)
                  .fade(duration: 500.ms, curve: Curves.easeOut)
                  .slideY(begin: 0.1, duration: 500.ms, curve: Curves.easeOut)
                  .scale(
                    begin: const Offset(0.97, 0.97),
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
