import 'package:flutter/material.dart';

class SelectInput extends StatelessWidget {
  final String label;
  final List<String> options;
  final String? value;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;

  const SelectInput({
    super.key,
    required this.label,
    required this.options,
    required this.value,
    required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final uniqueOptions = options.toSet().toList();

    return SizedBox(
      width: 250,
      child: DropdownButtonFormField<String>(
        value: value,
        hint: const Text("Selecione"),
        validator: validator,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: uniqueOptions
            .map(
              (e) => DropdownMenuItem<String>(
                value: e,
                child: SizedBox(
                  width: 200,
                  child: Text(e, overflow: TextOverflow.ellipsis, maxLines: 1),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
