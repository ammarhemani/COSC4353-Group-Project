import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String? selectedValue;
  final Function(String?) onChanged;
  final List<String> options;
  final String labelText;
  final String? Function(String?)? validator;

  const CustomDropdownField({super.key, required this.selectedValue, required this.onChanged, required this.options, required this.labelText, this.validator});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        color: Colors.black,
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.w500,
        fontSize: 15,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        isDense: false,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 14),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.outline)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).colorScheme.primary)),
      ),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down),
      items: options.map((String option) {
        return DropdownMenuItem<String>(
          value: option,
          child: Text(option),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
